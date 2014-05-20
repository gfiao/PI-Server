class CreateTagContents < ActiveRecord::Migration
  def change
    create_table :tag_contents do |t|
      t.integer :content_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
