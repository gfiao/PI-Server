class CreateWeathers < ActiveRecord::Migration
  def change
    create_table :weathers do |t|
      t.date :date
      t.integer :min_temp
      t.integer :max_temp
      t.string :city

      t.timestamps
    end
  end
end
