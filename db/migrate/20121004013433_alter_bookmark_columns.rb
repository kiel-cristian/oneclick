class AlterBookmarkColumns < ActiveRecord::Migration
  def up
  	# remove_column :categories,:category_id
  	# remove_column :categories,:categories_id
  	# remove_column :categories,:category
  	# remove_column :categories,:name
  	change_table :bookmarks do |t|
  		# t.remove_index :column => :category_id
  		# t.remove_index :column => :categories_id

  		# t.remove(:category_id)
  		# t.remove(:categories_id)
  		t.remove(:category)

  		# t.references :categories
  	end
  end

  def down

  end
end
