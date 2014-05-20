class CreateFreeClassrooms < ActiveRecord::Migration
  def change
    create_table :free_classrooms do |t|
      t.integer :user_id
      t.integer :classroom_id
      t.datetime :time

      t.timestamps
    end
  end
end
