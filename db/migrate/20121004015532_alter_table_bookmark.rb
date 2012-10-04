class AlterTableBookmark < ActiveRecord::Migration
  def up
  	remove_column :bookmarks,:url
  	remove_column :bookmarks,:popularity
  	remove_column :bookmarks,:security

  	# t.string   "url"
   #  t.integer  "popularity"
   #  t.integer  "security"
  	change_table :bookmarks do |t|
  		t.references :categories,		null: false
  		t.string   :url, 				null: false
   	 	t.integer  :popularity,			null: false
    	t.integer  :security,			null: false
  	end
  end

  def down
  end
end
