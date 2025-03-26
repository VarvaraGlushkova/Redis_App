class Answer < ApplicationRecord
  belongs_to :task
  has_many :comments
  has_many :likes, as: :likeable, dependent: :destroy

  validates :user_name, :answer_img, :description, presence: true


  mount_uploader :answer_img, AnswerImgUploader
end
