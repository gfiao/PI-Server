json.array!(@menus) do |menu|
  json.extract! menu, :id, :meal, :dish, :date
  json.url menu_url(menu, format: :json)
end
