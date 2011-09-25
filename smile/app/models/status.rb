class Status < ActiveRecord::Base
  attr_accessible :name, :category
  has_many :listings
  has_many :testies
  has_many :pests
end
