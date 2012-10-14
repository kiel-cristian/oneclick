class Vote < ActiveRecord::Base
  attr_accessible :name,:description

  def get_description
  	return self.description
  end
end
