class AddDefaultToProjects < ActiveRecord::Migration[7.0]
  def change
    change_column_default :projects, :completed, from: nil, to: false
    change_column_default :tasks, :completed, from: nil, to: false
    change_column_default :sub_tasks, :completed, from: nil, to: false
  end
end
