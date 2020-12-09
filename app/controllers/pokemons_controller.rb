require 'json'
require 'open-uri'

class PokemonsController < ApplicationController
    def index
        @pokemon = Pokemon.paginate(page: params[:page], per_page: 5).order(params[:sort_param])
    end    

    def show
        @pokemon = Pokemon.find(params[:id])

        url = "https://pokeapi.co/api/v2/pokemon/#{@pokemon.name.downcase}"

        if url.include?" " 
            url = "https://pokeapi.co/api/v2/pokemon/ditto"
        elsif @pokemon.number > 721
            url = "https://pokeapi.co/api/v2/pokemon/ditto"
        end
        
        open_url = open(url).read
        url_parsed = JSON.parse(open_url)
        @pokemon_image = url_parsed["sprites"]["other"]["official-artwork"]["front_default"]
    end

    def create 
        @pokemon = Pokemon.new(pokemon_params)

        @pokemon.total = @pokemon.hp.to_i + @pokemon.attack.to_i + @pokemon.defense.to_i + @pokemon.sp_atk.to_i + @pokemon.sp_def.to_i + @pokemon.speed.to_i
        @pokemon.number = Pokemon.last.number.to_i + 1
        
        if @pokemon.save!
            redirect_to pokemon_path(@pokemon)
        else
            render :new
        end
    end

    def new
        @pokemon = Pokemon.new
        @pokemon.total = @pokemon.hp.to_i + @pokemon.attack.to_i + @pokemon.defense.to_i + @pokemon.sp_atk.to_i + @pokemon.sp_def.to_i + @pokemon.speed.to_i
    end

    def edit
        @pokemon = Pokemon.find(params[:id])
        @pokemon.total = @pokemon.hp.to_i + @pokemon.attack.to_i + @pokemon.defense.to_i + @pokemon.sp_atk.to_i + @pokemon.sp_def.to_i + @pokemon.speed.to_i
    end

    def update 
        @pokemon = Pokemon.find(params[:id])
        @pokemon.update(pokemon_params)
        @pokemon.total = @pokemon.hp.to_i + @pokemon.attack.to_i + @pokemon.defense.to_i + @pokemon.sp_atk.to_i + @pokemon.sp_def.to_i + @pokemon.speed.to_i

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
