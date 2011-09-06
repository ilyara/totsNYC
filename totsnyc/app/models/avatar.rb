class Avatar < ActiveRecord::Base
  attr_accessible :name, :img_url, :age_group, :location_name, :role
  belongs_to :role
end
