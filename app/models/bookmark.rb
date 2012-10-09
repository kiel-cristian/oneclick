#!/bin/env ruby
# encoding: utf-8
class Bookmark < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :url,:categories_id,:security,:popularity

  validates_presence_of :url, :message=>"no puede estar en blanco"
  validates_presence_of :categories_id, :message=>"no puede estar en blanco"

  validates_uniqueness_of :url
  validates_format_of :url, :with => URI::regexp(%w(http https)), :message => "debe ser una URL válida"

  def get_name()
  	c = Category.where(id: self.categories_id)
  	p c
  	if c.presence
  		return c.first.name
  	end
  end

end

