json.array!(@tag_contents) do |tag_content|
  json.extract! tag_content, :id, :content_id, :tag_id
  json.url tag_content_url(tag_content, format: :json)
end
