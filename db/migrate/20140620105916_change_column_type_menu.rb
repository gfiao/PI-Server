class ChangeColumnTypeMenu < ActiveRecord::Migration
  def change
    change_column :menus, :dish, :text
  end
end
