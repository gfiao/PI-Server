json.array!(@videos) do |video|
  json.extract! video, :id, :link, :content_id
  json.url video_url(video, format: :json)
end
