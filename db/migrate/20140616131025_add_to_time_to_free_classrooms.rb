class AddToTimeToFreeClassrooms < ActiveRecord::Migration
  def change
    add_column :free_classrooms, :to_time, :datetime
  end
end
