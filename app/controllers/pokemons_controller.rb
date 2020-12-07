class PokemonsController < ApplicationController
    def index
        @pokemon = Pokemon.all
    end    

    def show
        @pokemon = Pokemon.find(params[:id])
    end

    def create 
        @pokemon = Pokemon.new(pokemon_params)
        
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
