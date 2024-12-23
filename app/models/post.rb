class Post < ApplicationRecord
  before_action :authenticate_user!
end
