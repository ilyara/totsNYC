class CreateDids < ActiveRecord::Migration
  def self.up
    create_table :dids do |t|
      t.references :provider
      t.string :number
      t.references :status
      t.timestamps
    end
  end

  def self.down
    drop_table :dids
  end
end
