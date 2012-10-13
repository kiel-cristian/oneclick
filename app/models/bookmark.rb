#!/bin/env ruby
# encoding: utf-8
class Bookmark < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :url,:categories_id,:security,:popularity

  validates_presence_of :url, :message=>"no puede estar en blanco"
  validates_presence_of :categories_id, :message=>"no puede estar en blanco"

  validates_uniqueness_of :url
  validates_format_of :url, :with => URI::regexp(%w(http https)), :message => "debe ser una URL válida"

  # insecure    = (-100..-50)
  # suspicious  = (-49,-20)
  # pending     = (-19,19)
  # confiable   = (20,49)
  # secure      = (50,100)

  def get_name()
  	c = Category.where(id: self.categories_id)
  	p c
  	if c.presence
  		return c.first.name
  	end
  end

  def get_security_level()
    invalid     = (-200..-101)
    insecure    = (-100..-50)
    suspicious  = (-49..-20)
    pending     = (-19..19)
    confiable   = (20..49)
    secure      = (50..100)
    if insecure.member? self.invalid
      return 0
    elsif insecure.member? self.insecure
      return 1
    elsif suspicious.member? self.suspicious
      return 2
    elsif pending.member? self.pending
      return 3
    elsif confiable.member? self.confiable
      return 4
    elsif secure.member? self.secure
      return 5
    end
  end

  def change_security(factor, points,div)
    current_b = Bookmark.find(self.id)
    if current_b.presence
      current_b.change(factor,points,div)
    end
  end

  def change(factor,points,div)
    new_security = self.security + (factor*points / div)
    if new_security > 100
      new_security = 100
    elsif new_security < -100
      new_security = -100
    end

    self.update_attributes(security: new_security)
  end

end
