class Status < ActiveRecord::Base
  attr_accessible :name, :ns
  has_many :companies
end
