class Task < ApplicationRecord
  has_many :answers
  has_many :comments
end
