class Gadfly < ActiveRecord::Base
  attr_accessible :name, :meaning, :category_id
  belongs_to :category
end
