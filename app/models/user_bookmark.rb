class UserBookmark < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :users_id,:bookmarks_id
end
