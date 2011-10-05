class Listing < ActiveRecord::Base
  attr_accessible :gist, :pitch
  has_many :comments
end
