class CreateHours < ActiveRecord::Migration
  def change
    create_table :hours do |t|
      t.integer :hour
      t.integer :minute

      t.timestamps
    end
  end
end
