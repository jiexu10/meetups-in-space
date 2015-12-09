class AddNullValidationsComments < ActiveRecord::Migration
  def up
    remove_reference :comments, :user
    remove_reference :comments, :meetup

    add_belongs_to :comments, :user, null: false
    add_belongs_to :comments, :meetup, null: false
  end

  def down
    remove_reference :comments, :user
    remove_reference :comments, :meetup
    
    add_belongs_to :comments, :user
    add_belongs_to :comments, :meetup
  end
end
