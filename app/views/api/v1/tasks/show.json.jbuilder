json.extract! @task, :name, :descroption, :image, :updated_at

json.set! :answers do
  json.array! @task.answers, partial: "api/v1/tasks/answer", as: :answer
end
