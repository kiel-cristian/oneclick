class UserBookmark < ActiveRecord::Base
  # attr_accessible :title, :body
  devise :database_authenticatable, :timeoutable
  
  attr_accessible :users_id,:bookmarks_id
end
