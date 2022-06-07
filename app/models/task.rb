class Task < ApplicationRecord
  belongs_to :project
  has_many :sub_tasks, dependent: :destroy
  validates :name, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validates_presence_of :start_date, :end_date
  validate :end_date_is_after_start_date
  validate :start_date_is_before_today
  has_many_attached :files



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
