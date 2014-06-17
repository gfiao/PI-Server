json.array!(@hours) do |hour|
  json.extract! hour, :id, :hour, :minute
  json.url hour_url(hour, format: :json)
end
