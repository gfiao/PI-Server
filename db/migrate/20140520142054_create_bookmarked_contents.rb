class CreateBookmarkedContents < ActiveRecord::Migration
  def change
    create_table :bookmarked_contents do |t|
      t.integer :user_id
      t.integer :content_id

      t.timestamps
    end
  end
end
