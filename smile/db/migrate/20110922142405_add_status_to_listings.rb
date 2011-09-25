class AddStatusToListings < ActiveRecord::Migration
  def change
    remove_column    :listings, :status
    add_column    :listings, :status_id, :integer
  end
end
