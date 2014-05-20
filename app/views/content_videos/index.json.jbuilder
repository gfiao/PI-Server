json.array!(@content_videos) do |content_video|
  json.extract! content_video, :id, :content_id, :video_id
  json.url content_video_url(content_video, format: :json)
end
