class CreateGadflies < ActiveRecord::Migration
  def self.up
    create_table :gadflies do |t|
      t.string :name
      t.string :meaning
      t.references :category
      t.timestamps
    end
  end

  def self.down
    drop_table :gadflies
  end
end
