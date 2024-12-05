json.extract! answer, :user_name, :description, :answer_img, :updated_at

json.set! :comments do
  json.array! @answer.comments, partial: "api/v1/comments/comment", as: :comment
end
