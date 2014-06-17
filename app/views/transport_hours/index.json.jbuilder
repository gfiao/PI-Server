json.array!(@transport_hours) do |transport_hour|
  json.extract! transport_hour, :id, :transport_id, :hour_id
  json.url transport_hour_url(transport_hour, format: :json)
end
