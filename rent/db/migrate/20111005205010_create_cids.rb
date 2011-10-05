class CreateCids < ActiveRecord::Migration
  def self.up
    create_table :cids do |t|
      t.string :number
      t.references :status
      t.timestamps
    end
  end

  def self.down
    drop_table :cids
  end
end
