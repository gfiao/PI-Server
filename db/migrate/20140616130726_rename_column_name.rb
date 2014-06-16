class RenameColumnName < ActiveRecord::Migration

  def change
    rename_column :free_classrooms, :time, :from_time
  end
end
