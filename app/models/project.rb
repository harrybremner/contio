class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :messages, dependent: :destroy
  belongs_to :client, class_name: "User"
  belongs_to :contractor, class_name: "User"
  validates :name, presence: true
  validates :description, presence: true
  validates :budget, presence: true
  validates_presence_of :start_date, :end_date
  validate :end_date_is_after_start_date, on: :create
  validate :start_date_is_before_today, on: :create
  #trying to add stuff for simple_calendar to work
  alias_attribute :start_time, :start_date
  alias_attribute :end_time, :end_date



  def multi_days?
    (end_time.to_date - start_time.to_date).to_i >= 1
  end

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
