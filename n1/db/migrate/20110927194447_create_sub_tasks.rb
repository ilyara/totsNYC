class CreateSubTasks < ActiveRecord::Migration
  def change
    create_table :sub_tasks do |t|
      t.references :task
      t.string :name

      t.timestamps
    end
    add_index :sub_tasks, :task_id
  end
end
