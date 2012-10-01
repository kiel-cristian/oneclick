class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
    	t.string :url
    	t.integer :popularity
    	t.integer :security
    	t.string :category

      t.timestamps
    end
  end
end
