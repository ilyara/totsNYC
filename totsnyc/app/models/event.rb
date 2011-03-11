# == Schema Information
# Schema version: 20110310211638
#
# Table name: events
#
#  id             :integer         not null, primary key
#  name           :string(255)
#  description    :string(255)
#  start_datetime :datetime
#  recurrence     :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Event < ActiveRecord::Base
end
