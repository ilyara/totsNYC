# == Schema Information
# Schema version: 20110310211638
#
# Table name: lores
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  georef      :integer
#

class Lore < ActiveRecord::Base
end
