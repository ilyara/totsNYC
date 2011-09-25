class CreateListings < ActiveRecord::Migration
  def self.up
    create_table :listings do |t|
      t.string :number
      t.string :code_word
      t.string :location
      t.string :terms
      t.string :status
      t.string :pitch
      t.string :comments
      t.string :source
      t.string :status
      t.string :assigned_phone

      t.timestamps
    end
  end

  def self.down
    drop_table :listings
  end
end
