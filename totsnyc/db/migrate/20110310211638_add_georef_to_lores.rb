class AddGeorefToLores < ActiveRecord::Migration
  def self.up
    add_column :lores, :georef, :integer
  end

  def self.down
    remove_column :lores, :georef
  end
end
