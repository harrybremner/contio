class SubTask < ApplicationRecord
  belongs_to :task
  validates :name, presence: true
  validates :description, presence: true

end
