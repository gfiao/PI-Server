json.array!(@footer_news) do |footer_news|
  json.extract! footer_news, :id, :category, :news, :date
  json.url footer_news_url(footer_news, format: :json)
end
