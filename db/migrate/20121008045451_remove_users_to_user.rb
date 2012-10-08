class RemoveUsersToUser < ActiveRecord::Migration
  def up
  	remove_column :users, :users
  end

  def down
  end
end
