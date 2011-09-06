class Person < ActiveRecord::Base
  belongs_to :role
  def role=(role_id)
    self.role_id = role_id
  end
end
