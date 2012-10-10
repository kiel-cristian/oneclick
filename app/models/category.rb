class Category < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :id,:name

  def self.get_names()
  	categories = Category.all

  	p categories

  	cat = []

    cat.push(id: 0,name: "Todas")
  	categories.each do |c|
  		cat.push(id: c.id,name: c.name)
  	end

  	return cat
  end
end
