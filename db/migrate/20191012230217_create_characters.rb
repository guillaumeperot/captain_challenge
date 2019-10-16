class CreateCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :health
      t.integer :attack
      t.integer :speed, default: 1
      t.integer :dodge_rate, default: 0
      t.integer :critical_rate, default: 0
      t.attachment :avatar

      t.timestamps null: false
    end
  end
end
