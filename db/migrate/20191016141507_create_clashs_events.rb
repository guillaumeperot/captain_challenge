class CreateClashsEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :clash_events do |t|
      t.integer :clash_id

      t.string :attacker_name
      t.integer :attack_type
      t.integer :attack_damage

      t.string :defender_name
      t.integer :defend_type
      t.integer :defender_health

      t.timestamps null: false
    end

    add_index :clash_events, :clash_id
  end
end
