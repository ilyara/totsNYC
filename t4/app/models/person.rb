class Person < ActiveRecord::Base
  belongs_to :role
  has_many :signups
  def role=(role_id)
    self.role_id = role_id
  end
end
