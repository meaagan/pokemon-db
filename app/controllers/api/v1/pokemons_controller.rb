class Api::V1::PokemonsController < ApplicationController
    def index
      @pokemons = Pokemon.all
    end

    def show
        @pokemon = Pokemon.find(params[:id])
    end

    def create 
        @pokemon = Pokemon.new(pokemon_params)
       
        if @pokemon.save
            render :show, status: :created
        else
            render_error
        end
    end

    def destroy
        @pokemon = Pokemon.find(params[:id])
        @pokemon.destroy
        head :no_content
    end

    private


    def pokemon_params
        params.require(:pokemon).permit(:number, :name, :type_1, :type_2, :total, :hp, :attack, :defense, :sp_atk, :sp_def, :speed, :generation, :legendary)
    end
end