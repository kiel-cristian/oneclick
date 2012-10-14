class UserBookmark < ActiveRecord::Base
  # attr_accessible :title, :body
  devise :database_authenticatable, :timeoutable

  attr_accessible :users_id,:bookmarks_id,:vote

  def get_url()
  	b = Bookmark.where(id: self.bookmarks_id)
  	if b.presence
  		return b.first.url
  	end
  end
end
