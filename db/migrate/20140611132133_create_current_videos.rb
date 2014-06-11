class CreateCurrentVideos < ActiveRecord::Migration
  def change
    create_table :current_videos do |t|
      t.integer :index

      t.timestamps
    end
  end
end
