# == Schema Information
# Schema version: 20110311212614
#
# Table name: tags
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  tag_type    :string(255)
#


class Tag < ActiveRecord::Base
end
