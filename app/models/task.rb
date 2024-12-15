class Task < ApplicationRecord
  has_many :answers
  belongs_to :theme

  mount_uploader :image, TaskImageUploader
end
