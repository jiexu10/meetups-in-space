require 'sinatra'
require_relative 'config/application'
require 'pry'

helpers do
  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find(user_id) if user_id.present?
  end

  def signed_in?
    !session[:user_id].nil?
  end
end

get '/' do
  redirect '/meetups'
end

get '/auth/github/callback' do
  user = User.find_or_create_from_omniauth(env['omniauth.auth'])
  session[:user_id] = user.id
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/meetups' do
  @meetups = Meetup.order(name: :asc)
  @users = User.all
  @signed_in = signed_in?
  erb :'meetups/index'
end

get '/meetup/:id' do
  @meetup = Meetup.where("id = ?", params[:id]).first
  @member = @meetup.user_is_a_member?(session[:user_id])
  @signed_in = signed_in?
  @creator = (session[:user_id] == @meetup.creator_id)
  erb :'meetups/show'
end

post '/meetup/join/:id' do
  current_meetup = Meetup.find(params[:id])
  @meetup = current_meetup
  if session[:user_id].nil?
    @member = false
    flash.now[:notice] = "Please Sign In"
    erb :'meetups/show'
  else
    Membership.create({user: current_user, meetup: current_meetup})
    flash.now[:notice] = "you joined"
    @member = @meetup.user_is_a_member?(session[:user_id])
    erb :'meetups/show'
  end
end

post '/meetup/leave/:id' do
  current_membership = Membership.where('user_id = ? AND meetup_id = ?', session[:user_id], params[:id])
  current_membership.first.delete
  @meetup = Meetup.find(params[:id])
  @member = @meetup.user_is_a_member?(session[:user_id])
  flash.now[:notice] = "you left"
  erb :'meetups/show'
end

get '/meetups/new' do
  if !session[:user_id].nil?
    erb :'meetups/new'
  else
    redirect '/auth/github'
  end
end

post '/meetups/new' do
  @name = params[:name].strip
  @location = params[:location].strip
  @description = params[:description].strip

  if @name.empty? || @location.empty? || @description.empty?
    flash.now[:notice] = "yo fill this out"
    erb :'meetups/new'
  else
    new_meetup = Meetup.create({name: @name, location: @location, description: @description, creator_id: session[:user_id]})
    redirect "/meetup/#{new_meetup.id}"
  end
end

get '/meetups/edit/:id' do
  current_meetup = Meetup.find(params[:id])
  @meetup = current_meetup
  erb :'meetups/edit'
end

patch '/meetups/edit/:id' do
  @name = params[:name].strip
  @location = params[:location].strip
  @description = params[:description].strip
  @meetup = Meetup.find(params[:id])

  if @name.empty? || @location.empty? || @description.empty?
    flash.now[:notice] = "yo fill this out"
    erb :'meetups/edit'
  else
    meetup_attributes = {name: @name, location: @location, description: @description}
    @meetup.update_attributes(meetup_attributes)
    redirect "/meetup/#{@meetup.id}"
  end
end

delete '/meetup/:id' do
  meetup = Meetup.find(params[:id])
  meetup.delete
  # memberships = Membership.where("#{meetup} = ?", meetup)
  memberships = Membership.where(meetup: meetup)
  memberships.delete_all
  # binding.pry
  redirect '/meetups'
end
