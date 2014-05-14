class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.date :birth_date
      t.string :gender
      t.string :course
      t.string :about_me

      t.timestamps
    end
  end
end
