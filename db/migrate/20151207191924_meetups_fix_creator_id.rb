class MeetupsFixCreatorId < ActiveRecord::Migration
  def change
    change_column :meetups, :creator_id, :integer, :null => false
  end
end
