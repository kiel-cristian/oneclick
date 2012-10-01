class Bookmark < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :url,:category,:security,:popularity
end
