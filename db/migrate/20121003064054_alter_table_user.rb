class AlterTableUser < ActiveRecord::Migration
  def up
  	add_index :users, :username,	null: false, unique: true
  end

  def down
  	remove_column :users, :username
  end
end
