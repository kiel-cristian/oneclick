class AlterTableBookmarks < ActiveRecord::Migration
  def up
  	remove_columns :bookmarks, :categories_id
  	change_table :bookmarks do |t|
  		t.string :category, null: false
  	end

  	add_index :bookmarks,:category ,null:false, unique: true
  end

  def down
  end
end
