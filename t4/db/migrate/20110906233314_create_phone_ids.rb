class CreatePhoneIds < ActiveRecord::Migration
  def change
    create_table :phone_ids do |t|
      t.string :number

      t.timestamps
    end
  end
end
