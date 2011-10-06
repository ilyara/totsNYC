class AddLatLonToBuilding < ActiveRecord::Migration
  def self.up
    add_column :buildings, :latitude, :float
    add_column :buildings, :longitude, :float
  end

  def self.down
    remove_column :buildings, :latitude
    remove_column :buildings, :longitude
  end
end
