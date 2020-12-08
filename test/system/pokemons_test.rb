require "application_system_test_case"

class PokemonsTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit pokemons_url
  
    assert_selector "h1", text: "Pokemon Database"
  end
end
