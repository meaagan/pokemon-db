require 'json'
require 'open-uri'

class PokemonsController < ApplicationController
    def index
        # Paginate Pokemon results and create an order based on the passed params 
        @pokemon = Pokemon.paginate(page: params[:page], per_page: 5).order(params[:sort_param])
    end    

    def show
        @pokemon = Pokemon.find(params[:id])

        # Find Pokemon's photo in poke API
        url = "https://pokeapi.co/api/v2/pokemon/#{@pokemon.name.downcase}"

        # If the Pokemon's name has a space in it or if it is a new Pokemon, use Ditto's image
        if url.include?" " 
            url = "https://pokeapi.co/api/v2/pokemon/ditto"
        elsif @pokemon.number > 721
            url = "https://pokeapi.co/api/v2/pokemon/ditto"
        end
        
        # Parse Poke API to find official artwork of the pokemon 
        open_url = open(url).read
        url_parsed = JSON.parse(open_url)
        @pokemon_image = url_parsed["sprites"]["other"]["official-artwork"]["front_default"]
    end

    def create 
        @pokemon = Pokemon.new(pokemon_params)

        # Calculate total for new Pokemon 
        @pokemon.total = @pokemon.hp.to_i + @pokemon.attack.to_i + @pokemon.defense.to_i + @pokemon.sp_atk.to_i + @pokemon.sp_def.to_i + @pokemon.speed.to_i

        # Automatically add new Pokemon to end of list
        @pokemon.number = Pokemon.last.number.to_i + 1

        # Convert form boolean to string that matches the CSV 
        if @pokemon.legendary == '1'
            @pokemon.legendary = 'True'
        else
            @pokemon.legendary = 'False'
        end
        
        # Redirect to new pokemon show page unless there is an error
        if @pokemon.save!
            redirect_to pokemon_path(@pokemon)
        else
            render :new
        end
    end

    def new
        @pokemon = Pokemon.new
        # Calculate total for new Pokemon 
        @pokemon.total = @pokemon.hp.to_i + @pokemon.attack.to_i + @pokemon.defense.to_i + @pokemon.sp_atk.to_i + @pokemon.sp_def.to_i + @pokemon.speed.to_i
    end

    def edit
        @pokemon = Pokemon.find(params[:id])

        # Calculate total for edited Pokemon 
        @pokemon.total = @pokemon.hp.to_i + @pokemon.attack.to_i + @pokemon.defense.to_i + @pokemon.sp_atk.to_i + @pokemon.sp_def.to_i + @pokemon.speed.to_i
    end

    def update 
        @pokemon = Pokemon.find(params[:id])
        @pokemon.update(pokemon_params)

        # Calculate total for edited Pokemon 
        @pokemon.total = @pokemon.hp.to_i + @pokemon.attack.to_i + @pokemon.defense.to_i + @pokemon.sp_atk.to_i + @pokemon.sp_def.to_i + @pokemon.speed.to_i

        # If the pokemon does not have any errors, redirect to it's show page
        if @pokemon.save!
            redirect_to pokemon_path(@pokemon)
        else
            render :edit
        end
    end

    def destroy 
        @pokemon = Pokemon.find(params[:id])
        @pokemon.destroy

        redirect_to pokemons_path
    end


    private

    def pokemon_params
        params.require(:pokemon).permit(:number, :name, :type_1, :type_2, :total, :hp, :attack, :defense, :sp_atk, :sp_def, :speed, :generation, :legendary)
    end
end
