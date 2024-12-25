class Comment < ApplicationRecord
  belongs_to :answer
  belongs_to :user

  has_many :replies, class_name: "Comment", foreign_key: "comment_id", dependent: :destroy
  belongs_to :comment, optional: true

  validates :body_content, presence: true
end
