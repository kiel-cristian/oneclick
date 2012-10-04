class Bookmark < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :url,:categories_id,:security,:popularity,:category

  validates_presence_of :url, :message=>"no puede estar en blanco"
  validates_presence_of :categories_id, :message=>"no puede estar en blanco"

  # validates_uniqueness_of :url
  validates_format_of :url, :with => URI::regexp(%w(http https))

end

