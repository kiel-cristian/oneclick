#!/bin/env ruby
# encoding: utf-8
class Bookmark < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :url,:categories_id,:security,:popularity

  validates_presence_of :url, :message=>"no puede estar en blanco"
  validates_presence_of :categories_id, :message=>"no puede estar en blanco"

  validates_uniqueness_of :url
  validates_format_of :url, :with => URI::regexp(%w(http https)), :message => "debe ser una URL válida"

  def change_security(points,div)
    new_security = self.security + 1.0*(points / div)
    if new_security > 500
      new_security = 500
    elsif new_security < -200
      new_security = -200
    end

    p "NEW SECURITY"
    p new_security.inspect

    self.update_attributes(security: new_security)
  end

end
