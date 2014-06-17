class AddImageUrlToWeather < ActiveRecord::Migration
  def change
    add_column :weathers, :image_url, :string
  end
end
