class Profile < ApplicationRecord
  belongs_to :user

  validates :name, presence: true

  mount_uploader :image, TaskImageUploader
  # validates :bio, length: { maximum: 300 }
end
