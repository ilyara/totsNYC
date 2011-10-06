class Company < ActiveRecord::Base
  attr_accessible :name, :status_id
  belongs_to :status
  has_many :buildings
end
