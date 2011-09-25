class CreatePests < ActiveRecord::Migration
  def self.up
    create_table :pests do |t|
      t.string :name
      t.references :status
      t.timestamps
    end
  end

  def self.down
    drop_table :pests
  end
end
