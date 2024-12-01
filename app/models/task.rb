class Task < ApplicationRecord
  has_many :answers

  mount_uploader :image, TaskImageUploader
end
