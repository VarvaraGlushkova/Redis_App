class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_many :tasks
  has_many :answers
  has_many :comments

  # A user has one profile
  has_one :profile, dependent: :destroy #so after deletes user profile delets too


  before_create :generate_jti



  # Ensure each user has a profile (if not already created)
  after_create :build_profile


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self




  

  private
  def generate_jti
    self.jti ||= SecureRandom.uuid
  end

  
  def extract_name_from_email(email)
    email.split("@").first.capitalize
  end


  # In case already has profile so no duplicates are present
  def build_profile
      self.create_profile! unless self.profile.present?
  end

end
