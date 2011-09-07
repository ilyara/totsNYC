class ModifyPhoneId < ActiveRecord::Migration
  def change
    rename_column :call_logs, :phone_id, :phone_id_id
    remove_column :call_logs, :end_time
    add_column :call_logs, :duration, :integer
    add_index :call_logs, :phone_id_id
  end
end
