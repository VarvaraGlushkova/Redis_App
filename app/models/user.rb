class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_many :tasks
  has_many :answers
  has_many :comments

  # A user has one profile
  has_one :profile, dependent: :destroy #so after deletes user profile delets too

  after_create :create_user_profile


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self




  

  private
  # In case already has profile so no duplicates are present
  def create_user_profile
    self.create_profile! unless self.profile.present?
  end

end
