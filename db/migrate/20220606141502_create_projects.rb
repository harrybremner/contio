class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :budget
      t.boolean :completed
      t.date :start_date
      t.date :end_date
      t.integer :total_price
      t.references :client, foreign_key: { to_table: :users }
      t.references :contractor, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
