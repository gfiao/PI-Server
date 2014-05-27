class DropMenies < ActiveRecord::Migration


  def up
    drop_table :menies
  end

end
