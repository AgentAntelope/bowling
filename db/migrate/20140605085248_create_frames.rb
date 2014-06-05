class CreateFrames < ActiveRecord::Migration
  def change
    create_table :frames do |t|
      t.integer :player_id
      t.integer :first_score
      t.integer :second_score
      t.integer :third_score
      t.integer :position

      t.timestamps
    end
  end
end
