class CreateTesties < ActiveRecord::Migration
  def self.up
    create_table :testies do |t|
      t.string :name
      t.references :status
      t.timestamps
    end
  end

  def self.down
    drop_table :testies
  end
end
