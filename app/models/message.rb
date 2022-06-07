class Message < ApplicationRecord
  belongs_to :user
  validates :content, presence: true
  has_many_attached :files

  def show
  end

  def create
  end

  def destroy
  end
end
