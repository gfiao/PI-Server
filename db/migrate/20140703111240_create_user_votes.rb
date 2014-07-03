class CreateUserVotes < ActiveRecord::Migration
  def change
    create_table :user_votes do |t|
      t.integer :user_id
      t.integer :free_classroom_id
      t.string :status

      t.timestamps
    end
  end
end
