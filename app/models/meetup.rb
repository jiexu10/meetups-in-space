require_relative 'user'

class Meetup < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
  has_many :comments
  belongs_to :creator, class_name: 'User'
  validates :name, presence: true
  validates :location, presence: true
  validates :description, presence: true
  validates :creator, presence: true
  
  def user_is_a_member?(user_id)
    users.where("user_id = ?", user_id).any?
  end
end
