class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :meal
      t.string :dish
      t.date :date

      t.timestamps
    end
  end
end
