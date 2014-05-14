json.array!(@users) do |user|
  json.extract! user, :id, :name, :birth_date, :gender, :course, :about_me
  json.url user_url(user, format: :json)
end
