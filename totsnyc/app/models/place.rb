# == Schema Information
# Schema version: 20110310211638
#
# Table name: places
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Place < ActiveRecord::Base
end
