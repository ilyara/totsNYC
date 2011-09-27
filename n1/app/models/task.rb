class Task < ActiveRecord::Base
  validates_presence_of :name
  default_scope :conditions => {:done => false}
  has_many :sub_tasks
end
