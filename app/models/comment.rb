class Comment < ApplicationRecord
  belongs_to :answer
  belongs_to :user

  validates :user_name_title, :body_content, presence: true
end
