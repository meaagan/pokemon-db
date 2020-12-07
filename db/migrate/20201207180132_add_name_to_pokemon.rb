class AddNameToPokemon < ActiveRecord::Migration[6.0]
  def change
    add_column :pokemons, :name, :string
  end
end
