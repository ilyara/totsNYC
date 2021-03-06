class Listing < ActiveRecord::Base
  attr_accessible :gist, :pitch, :unit, :monthly_rent, :rooms_total, :rooms_bed, :rooms_bath, :building,  :building_id
  attr_accessible :address, :status_id, :status
  attr_writer :current_step, :address
  has_many :comments
  belongs_to :building
  belongs_to :status

  def steps
    %w[building unit gist]
  end
  
  def current_step
    @current_step || steps.first
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end
  
  def address
    @address || '123 City Avenue'
  end
  
  def address_geo
    address + "New York, NY, USA"
  end
end
