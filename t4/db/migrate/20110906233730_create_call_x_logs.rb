class CreateCallLogs < ActiveRecord::Migration
  def change
    create_table :call_logs do |t|
      t.references :phone
      t.datetime :start_time
      t.datetime :end_time
      t.string :comments

      t.timestamps
    end
    add_index :call_logs, :phone_id
  end
end
