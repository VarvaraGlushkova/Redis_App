json.extract! @theme, :theme_title, :theme_descr, :theme_cover

json.set! :tasks do
  json.array! @theme.tasks, partial: "api/v1/themes/task", as: :task
end
