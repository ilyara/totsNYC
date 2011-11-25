class User < ActiveRecord::Base
  attr_accessible :email, :providers_attributes
  
  has_many :providers, :class_name => "UserProvider", :dependent => :destroy
  accepts_nested_attributes_for :providers
  
  authenticates_with_sorcery!
end
