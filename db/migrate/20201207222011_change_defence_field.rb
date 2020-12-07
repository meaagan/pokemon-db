class ChangeDefenceField < ActiveRecord::Migration[6.0]
  def change
    rename_column :pokemons, :defence, :defense
  end
end
