class Listing < ActiveRecord::Base
  attr_accessible :ref, :code_word, :gist, :pitch, :comments, :status_id, :source, :assigned_phone, :location, :terms
  belongs_to :status
end
