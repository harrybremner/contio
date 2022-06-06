class Project < ApplicationRecord
  has_many :user_projects, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :users, through: :user_projects
  validates :name, presence: true
  validates :description, presence: true
  validates :budget, presence: true
  validates_presence_of :start_date, :end_date
  validate :end_date_is_after_start_date
  validate :start_date_is_before_today


  private

  def end_date_is_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "cannot be before the start date")
    end
  end

  def start_date_is_before_today
    if start_date < Date.today
      errors.add(:start_date, "date cannot be before today")
    end
  end

end
