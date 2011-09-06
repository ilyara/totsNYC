class CreateAvatars < ActiveRecord::Migration
  def self.up
    create_table :avatars do |t|
      t.string :name
      t.string :img_url
      t.string :age_group
      t.string :location_name
      t.references :role
      t.timestamps
    end
  end

  def self.down
    drop_table :avatars
  end
end
