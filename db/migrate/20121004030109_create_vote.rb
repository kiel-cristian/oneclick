class CreateVote < ActiveRecord::Migration
  def change
    create_table :votes do |t|
    	t.string	:name,				null: false
    	t.string	:description,		null: false, default: ""

      	t.timestamps
    end
    add_index :votes, [:name,:description], unique: true

    create_table :bookmarks_votes do |t|
    	t.references	:votes,		null:false
    	t.references	:bookmarks,		null:false
    	t.string		:message,		null:false,	default: ""

      t.timestamps
    end

  end
end
