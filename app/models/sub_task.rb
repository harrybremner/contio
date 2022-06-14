require 'pry-byebug'
class SubTask < ApplicationRecord
  belongs_to :task
  validates :name, presence: true
  validates :description, presence: true

  after_commit :check_tasks_completed


  def check_tasks_completed
    if self.task.sub_tasks.where(completed: true).count == self.task.sub_tasks.count
      self.task.update(completed: true)
    else
      self.task.update(completed: false)
    end
  end

end
