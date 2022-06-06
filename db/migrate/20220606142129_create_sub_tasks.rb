class CreateSubTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :sub_tasks do |t|
      t.references :task, null: false, foreign_key: true
      t.boolean :completed
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
