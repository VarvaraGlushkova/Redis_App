json.extract! task, :id, :name, :descroption, :image, :created_at, :updated_at
json.url task_url(task, format: :json)
