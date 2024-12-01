class Answer < ApplicationRecord
  belongs_to :task
  has_many :comments

  mount_uploader :answer_img, AnswerImgUploader
end
