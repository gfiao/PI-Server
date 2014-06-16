class DropUserContentsTable < ActiveRecord::Migration
  def change
    drop_table :user_contents
  end
end
