class CreateScoreBoard < ActiveRecord::Migration
  def change
    create_table :score_boards do |t|
      t.integer :user_id, index: true
      t.integer :score, index: true
      t.timestamps null: false
    end
  end
end
