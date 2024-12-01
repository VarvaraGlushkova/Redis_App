class Answer < ApplicationRecord
  belongs_to :task
  has_many :comments
end
