class CreateCallLogs < ActiveRecord::Migration
  def self.up
    create_table :call_logs do |t|
      t.references :cid
      t.string :comments
      t.timestamps
    end
  end

  def self.down
    drop_table :call_logs
  end
end
