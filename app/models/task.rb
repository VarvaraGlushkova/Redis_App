class Task < ApplicationRecord
  has_many :answers
  belongs_to :theme
  belongs_to :user

  validates :name, :image, :descroption, presence: true

  mount_uploader :image, TaskImageUploader
end
