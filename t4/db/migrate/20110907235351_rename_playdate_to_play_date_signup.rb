class RenamePlaydateToPlayDateSignup < ActiveRecord::Migration
  def up
    rename_column :signups, :playdate_id, :play_date_id
  end

  def down
  end
end
