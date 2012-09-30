class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
    	t.integer :popularity
    	t.integer :security
    	t.string :category
    	t.references :users

      	t.timestamps
    end
  end
end
