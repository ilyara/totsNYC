class Pest < ActiveRecord::Base
  attr_accessible :name, :status_id
  belongs_to :status
end
