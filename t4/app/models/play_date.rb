class PlayDate < ActiveRecord::Base
  belongs_to :location
  belongs_to :person
  has_many :signups
end
