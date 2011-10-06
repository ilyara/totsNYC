class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  attr_accessible :username, :email, :role, :password, :password_confirmation
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  
  belongs_to :role
  
  def role?(rolename)
    role.rolename == rolename
  end
end
