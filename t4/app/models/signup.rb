class Signup < ActiveRecord::Base
  belongs_to :play_date
  belongs_to :person
end
