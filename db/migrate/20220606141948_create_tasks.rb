class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.references :project, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.integer :price
      t.date :start_date
      t.date :end_date
      t.boolean :completed
      t.string :priority
      t.boolean :approved

      t.timestamps
    end
  end
end
