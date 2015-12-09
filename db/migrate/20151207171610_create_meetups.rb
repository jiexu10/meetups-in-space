class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :location, null: false
      t.belongs_to :creator, index: true

      t.timestamps null: false
    end
  end
end
