class Message < ApplicationRecord
  belongs_to :user
  belongs_to :project
  validates :content, presence: true
  has_many_attached :files

end
