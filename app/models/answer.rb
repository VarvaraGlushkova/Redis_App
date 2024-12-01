class Answer < ApplicationRecord
  belongs_to :Task
  has_many :Comments
end
