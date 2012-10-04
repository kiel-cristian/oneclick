class AlterUniqueFromTables < ActiveRecord::Migration
  def up
  	add_index :categories,	:name,	unique: true
  	add_index :bookmarks,	:url,	unique: true

  	add_index :user_bookmarks,	[:users_id,:bookmarks_id],	unique: true

  end


  def self.down
  end

  def down
  end
end
