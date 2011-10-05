class Comment < ActiveRecord::Base
  attr_accessible :comment, :listing_id
  belongs_to :listing
end
