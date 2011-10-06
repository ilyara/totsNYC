class AddBuildingToListing < ActiveRecord::Migration
  def change
      add_column :listings, :unit, :string
      add_column :listings, :building_id, :integer
      add_column :listings, :listings_type_id, :integer
      add_column :listings, :room_config_id, :integer
      add_column :listings, :fee_type_id, :integer
      add_column :listings, :monthly_rent, :integer
      add_column :listings, :created_by_id, :integer
      add_column :listings, :rooms_total, :integer
      add_column :listings, :rooms_bed, :integer
      add_column :listings, :rooms_bath, :integer
  end
end
