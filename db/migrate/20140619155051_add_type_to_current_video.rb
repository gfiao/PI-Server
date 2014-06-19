class AddTypeToCurrentVideo < ActiveRecord::Migration
  def change
    add_column :current_videos, :type, :string
  end
end
