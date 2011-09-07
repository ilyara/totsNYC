class CreatePlayDates < ActiveRecord::Migration
  def change
    create_table :play_dates do |t|
      t.string :name
      t.references :location

      t.timestamps
    end
    add_index :play_dates, :location_id
  end
end
