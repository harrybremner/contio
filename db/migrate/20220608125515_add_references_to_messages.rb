class AddReferencesToMessages < ActiveRecord::Migration[7.0]
  def change
    add_reference :messages, :project
  end
end
