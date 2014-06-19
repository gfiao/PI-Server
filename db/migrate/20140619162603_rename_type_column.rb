class RenameTypeColumn < ActiveRecord::Migration
  def change
    rename_column :current_videos, :type, :content_type
  end
end
