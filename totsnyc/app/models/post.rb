# == Schema Information
# Schema version: 20110310214725
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
end
