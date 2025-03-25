json.extract! @user, :id, :email, :username, :bio, :contact, :portfolio, :is_admin, :avatar, :encrypted_password

# json.set! :favorites do
#   json.array! @user.favorites do |favorite|
#     json.partial! "api/v1/", effect: favorite.
#   end
end