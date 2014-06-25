json.array!(@current_videos) do |current_video|
  json.extract! current_video, :id, :index, :content_type
  json.url current_video_url(current_video, format: :json)
end
