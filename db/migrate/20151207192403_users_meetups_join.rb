class UsersMeetupsJoin < ActiveRecord::Migration
  def change
    create_table :membership do |t|
      t.belongs_to :meetup, index: true, null: false
      t.belongs_to :user, index: true, null: false

      t.timestamps null: false
    end
  end
end
