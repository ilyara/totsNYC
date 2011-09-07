class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.references :tag
      t.string :obj

      t.timestamps
    end
    add_index :taggings, :tag_id
  end
end
