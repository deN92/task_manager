json.extract! task, :id, :user_id, :task_name, :task_desc, :created_at, :updated_at
json.url task_url(task, format: :json)