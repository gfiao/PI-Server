class CreateFooterNews < ActiveRecord::Migration
  def change

    create_table :footer_news do |t|
      t.string :category
      t.string :news
      t.date :date

      t.timestamps
    end
  end
end
