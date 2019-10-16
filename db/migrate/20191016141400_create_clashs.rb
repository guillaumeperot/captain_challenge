class CreateClashs < ActiveRecord::Migration[6.0]
  def change
    create_table :clashs do |t|
      t.integer :winner_id
      t.integer :loser_id
      t.text :winner_attributes
      t.text :loser_attributes

      t.timestamps null: false
    end

    add_index :clashs, :winner_id
    add_index :clashs, :loser_id
  end
end
