class AddGistToListings < ActiveRecord::Migration
  def change
    add_column :listings, :gist, :string
  end
end
