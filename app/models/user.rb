class User < ApplicationRecord
  has_many :tasks
  has_many :answers
  has_many :comments

  has_one :profile


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :create_profile
end
