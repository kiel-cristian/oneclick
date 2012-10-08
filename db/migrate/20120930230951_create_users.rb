class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :username		,null: false
    	t.string :email			,null: false
    	t.boolean :admin		,null: false,default: false

      t.timestamps
    end
    add_index :users, :username,	null: false, unique: true
  end
end
