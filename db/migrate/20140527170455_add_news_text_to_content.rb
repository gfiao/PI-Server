class AddNewsTextToContent < ActiveRecord::Migration
  def change
    add_column :contents, :news_text, :text
  end
end
