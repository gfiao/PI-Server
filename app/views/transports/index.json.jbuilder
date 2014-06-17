json.array!(@transports) do |transport|
  json.extract! transport, :id, :carreira, :origin, :destination
  json.url transport_url(transport, format: :json)
end
