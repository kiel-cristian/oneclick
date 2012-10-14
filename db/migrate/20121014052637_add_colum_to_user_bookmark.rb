class AddColumToUserBookmark < ActiveRecord::Migration
  def change
  	change_table :user_bookmarks do |t|
  		t.integer :vote, null: false, default: 0
  	end
  end
end
