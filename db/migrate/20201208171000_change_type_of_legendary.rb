class ChangeTypeOfLegendary < ActiveRecord::Migration[6.0]
  def change
    change_column :pokemons, :legendary, :string
  end
end
