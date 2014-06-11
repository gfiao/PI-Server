json.array!(@current_videos) do |current_video|
  json.extract! current_video, :id, :index
  json.url current_video_url(current_video, format: :json)
end
