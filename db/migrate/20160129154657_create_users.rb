class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :phone, null: false
      t.integer :age
      t.string :sex
      t.timestamps null: false
    end
  end

  def down
    drop_table :users
  end
end