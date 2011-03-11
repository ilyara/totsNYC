# == Schema Information
# Schema version: 20110311212614
#
# Table name: kukus
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  comment    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Kuku < ActiveRecord::Base
end
