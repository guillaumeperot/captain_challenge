class AddPowerAndRankToCharacters < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :power, :integer
    add_column :characters, :rank, :integer
  end
end
