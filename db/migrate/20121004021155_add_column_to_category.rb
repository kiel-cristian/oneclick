class AddColumnToCategory < ActiveRecord::Migration
  def change
  	change_table :categories do |t|
  		t.string :name,			null: false
  	end
  end
end
