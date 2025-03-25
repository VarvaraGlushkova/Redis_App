json.extract! @profile, :name, :bio, :avatar

json.set! :answers do
  json.array! @profile.user.answers do |answer|
    json.partial! "api/v1/answers/answer", answer: answer
  end
end

# json.collections do
#   json.array! @profile.user.collections, partial: "api/v1/collections/collection", as: :collection
# end