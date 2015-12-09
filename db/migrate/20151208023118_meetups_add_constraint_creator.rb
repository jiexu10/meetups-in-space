class MeetupsAddConstraintCreator < ActiveRecord::Migration
  def up
    execute "ALTER TABLE meetups ADD CONSTRAINT FK_MEETUPS_USERS FOREIGN KEY (creator_id) REFERENCES users"
  end

  def down
    execute "ALTER TABLE meetups DROP CONSTRAINT FK_MEETUPS_USERS"
  end
end
