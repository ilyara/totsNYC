class Testie < ActiveRecord::Base
  attr_accessible :name, :status, :status_id
  belongs_to :status
end
