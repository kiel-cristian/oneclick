class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name ,null: false
      t.timestamps
    end

    create_table :bookmarks do |t|
    	t.string :url				,null: false
    	t.integer :popularity		,null: false
    	t.integer :security			,null: false
      t.references :categories
    	# t.string :category			,null: false

      t.timestamps
    end
  end
end
