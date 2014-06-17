json.array!(@weathers) do |weather|
  json.extract! weather, :id, :date, :min_temp, :max_temp, :city
  json.url weather_url(weather, format: :json)
end
