class AddViewNumberToContents < ActiveRecord::Migration
  def change
    add_column :contents, :views, :integer
  end
end
