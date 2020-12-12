json.array! @pokemons do |pokemon|
    json.extract! pokemon, :number, :name, :type_1, :type_2, :total, :hp, :attack, :defense, :sp_atk, :sp_def, :speed, :generation, :legendary
end