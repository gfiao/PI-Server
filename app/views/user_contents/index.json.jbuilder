json.array!(@user_contents) do |user_content|
  json.extract! user_content, :id, :user_id, :content_id
  json.url user_content_url(user_content, format: :json)
end
