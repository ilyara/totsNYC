class Role < ActiveRecord::Base
  attr_accessible :rolename, :description
  validates_presence_of :rolename
  validates_uniqueness_of :rolename
end
