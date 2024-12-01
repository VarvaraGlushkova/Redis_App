json.extract! answer, :id, :user_name, :description, :answer_img, :created_at, :updated_at
json.url answer_url(answer, format: :json)
