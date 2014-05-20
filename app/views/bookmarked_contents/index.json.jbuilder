json.array!(@bookmarked_contents) do |bookmarked_content|
  json.extract! bookmarked_content, :id, :user_id, :content_id
  json.url bookmarked_content_url(bookmarked_content, format: :json)
end
