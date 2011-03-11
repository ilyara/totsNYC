class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.string :description
      t.datetime :start_datetime
      t.integer :recurrence
      t.timestamps
    end
    create_table :places do |t|
      t.string :name
      t.string :description
      t.timestamps
    end
    create_table :lores do |t|
      t.string :name
      t.string :description
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
