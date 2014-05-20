json.array!(@contents) do |content|
  json.extract! content, :id, :title, :link_image, :description, :date
  json.url content_url(content, format: :json)
end
