class Signup < ActiveRecord::Base
  belongs_to :playdate
  belongs_to :person
end
