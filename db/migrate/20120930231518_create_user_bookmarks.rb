class CreateUserBookmarks < ActiveRecord::Migration
  def change
    create_table :user_bookmarks do |t|
    	t.references :users
    	t.references :bookmarks

      t.timestamps
    end
  end
end
