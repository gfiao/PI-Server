class CreateTransportHours < ActiveRecord::Migration
  def change
    create_table :transport_hours do |t|
      t.integer :transport_id
      t.integer :hour_id

      t.timestamps
    end
  end
end
