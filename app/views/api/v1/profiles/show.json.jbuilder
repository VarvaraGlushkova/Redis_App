json.extract! @profile, :name, :bio, :avatar, :user_id

json.set! :answers do
  json.array! @profile.user.answers do |answer|
    json.partial! "api/v1/answers/answer", answer: answer
  end
end
