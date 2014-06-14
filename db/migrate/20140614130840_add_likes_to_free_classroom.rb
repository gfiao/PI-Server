class AddLikesToFreeClassroom < ActiveRecord::Migration
  def change
    add_column :free_classrooms, :likes, :integer
  end
end
