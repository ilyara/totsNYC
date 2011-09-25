class RenameNumberToListingNumber < ActiveRecord::Migration
  def up
    rename_column :listings, :number, :ref
  end

  def down
    rename_column :listings, :ref, :number
  end
end
