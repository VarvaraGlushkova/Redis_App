class Theme < ApplicationRecord
  has_many :tasks

  mount_uploader :image, TaskImageUploader
end
