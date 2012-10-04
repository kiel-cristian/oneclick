class CreateDenunce < ActiveRecord::Migration
  def change
    create_table :denunces do |t|
    	t.string	:type,				null: false
    	t.string	:description,		null: false, default: ""

      	t.timestamps
    end
    add_index :denunces, [:type,:description], unique: true

    create_table :bookmarks_denunces do |t|
    	t.references	:denunces,		null:false
    	t.references	:bookmarks,		null:false
    	t.string		:message,		null:false,	default: ""

      	t.timestamps
    end

  end
end
