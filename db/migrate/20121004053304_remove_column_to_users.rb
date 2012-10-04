class RemoveColumnToUsers < ActiveRecord::Migration
  def up
  	remove_columns :users,:users
  end

  def down
  end
end
