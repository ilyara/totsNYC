class Status < ActiveRecord::Base
  attr_accessible :name, :ns
  has_many :companies
  scope :listing_status, where(:ns => 'listing_status')
end
