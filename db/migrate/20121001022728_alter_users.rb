class AlterUsers < ActiveRecord::Migration
  def up
    rename_column :users,:name ,:login
  	add_column :users,:salt,:string
    add_column :users,:hashed_password,:string

  end

  def down
  end
end


# class CreateUsers < ActiveRecord::Migration
#   def self.up
#     create_table :users do |t|
#       t.column :login, :string
#       t.column :hashed_password, :string
#       t.column :email, :string
#       t.column :salt, :string
#       t.column :created_at, :datetime
#     end    
#   end

#   def self.down
#     drop_table :users
#   end
# end