class CreateTransports < ActiveRecord::Migration
  def change
    create_table :transports do |t|
      t.integer :carreira
      t.string :origin
      t.string :destination

      t.timestamps
    end
  end
end
