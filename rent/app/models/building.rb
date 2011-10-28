class Building < ActiveRecord::Base
  attr_accessible :address, :company #, :company_id
  belongs_to :company
  has_many :listings
  geocoded_by :address_geo
  after_validation :geocode, :if => :address_changed?
  
  def address_geo
    address + "New York, NY, USA"
  end
end
