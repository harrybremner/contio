class Message < ApplicationRecord
  belongs_to :user
  belongs_to :project
  validates :content, presence: true
  has_many_attached :files


  # after_commit :send_notification


  # def send_notifcation
  # end

end
