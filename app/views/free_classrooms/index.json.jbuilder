json.array!(@free_classrooms) do |free_classroom|
  json.extract! free_classroom, :id, :user_id, :classroom_id, :time
  json.url free_classroom_url(free_classroom, format: :json)
end
