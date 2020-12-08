require 'json'
require 'open-uri'

class PokemonsController < ApplicationController
    def index
        @pokemon = Pokemon.all
    end    

    def show
        @pokemon = Pokemon.find(params[:id])

        url = "https://pokeapi.co/api/v2/pokemon/#{@pokemon.name.downcase}"
        open_url = open(url).read
        url_parsed = JSON.parse(open_url)
        @pokemon_image = url_parsed["sprites"]["other"]["official-artwork"]["front_default"]

        if @pokemon.legendary == true
            return "Legendary"
        else
            "Basic"
        end
    end

    def create 
        @pokemon = Pokemon.new(pokemon_params)

        @pokemon.number = Pokemon.last.number.to_i + 1
        
        if @pokemon.save!
            redirect_to pokemon_path(@pokemon)
        else
            render :new
        end
    end

    def new
        @pokemon = Pokemon.new
    end

    def edit
        @pokemon = Pokemon.find(params[:id])
    end

    def update 
        @pokemon = Pokemon.find(params[:id])
    end


    private

    def pokemon_params
        params.require(:pokemon).permit(:number, :name, :type_1, :type_2, :total, :hp, :attack, :defense, :sp_atk, :sp_def, :speed, :generation, :legendary)
    end
end
