class CreateContentVideos < ActiveRecord::Migration
  def change
    create_table :content_videos do |t|
      t.integer :content_id
      t.integer :video_id

      t.timestamps
    end
  end
end
