class CreateKukas < ActiveRecord::Migration
  def self.up
    create_table :kukas do |t|
      t.string :name
      t.string :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :kukas
  end
end
