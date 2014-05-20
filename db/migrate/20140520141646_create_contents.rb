class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :title
      t.string :link_image
      t.text :description
      t.date :date

      t.timestamps
    end
  end
end
