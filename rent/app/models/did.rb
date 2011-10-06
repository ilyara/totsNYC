class Did < ActiveRecord::Base
  attr_accessible :provider, :number, :status
  validates_presence_of :number
  validates_uniqueness_of :number
end
