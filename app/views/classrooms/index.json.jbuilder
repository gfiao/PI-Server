json.array!(@classrooms) do |classroom|
  json.extract! classroom, :id, :building, :classroom
  json.url classroom_url(classroom, format: :json)
end
