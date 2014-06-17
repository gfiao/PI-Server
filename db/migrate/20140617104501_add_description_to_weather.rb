class AddDescriptionToWeather < ActiveRecord::Migration
  def change
    add_column :weathers, :description, :text
  end
end
