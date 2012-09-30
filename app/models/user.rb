class User < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible			:email,:name,:isadmin,:password
  protected_attributes		:password
  # attr_not_nil :email,:name,:isadmin,:password
end