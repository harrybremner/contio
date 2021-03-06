class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :messages, dependent: :destroy
  has_one_attached :photo
  has_many :projects_as_client, class_name: "Project", foreign_key: :client_id, dependent: :destroy
  has_many :projects_as_contractor, class_name: "Project", foreign_key: :contractor_id, dependent: :destroy

  def full_name
    first_name + ' ' + last_name
  end
end
