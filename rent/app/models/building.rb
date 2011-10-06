class Building < ActiveRecord::Base
  attr_accessible :address, :company #, :company_id
  belongs_to :company
end
