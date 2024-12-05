json.extract! post, :id, :title, :body, :cover_img, :created_at, :updated_at
json.url post_url(post, format: :json)
