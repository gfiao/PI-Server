class AddContentIdToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :content_id, :integer
  end
end
