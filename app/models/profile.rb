class Profile < ApplicationRecord
  belongs_to :user

  # validates :name, presence: true
  # validates :bio, length: { maximum: 300 }
end
