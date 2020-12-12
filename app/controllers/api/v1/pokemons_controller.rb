class Api::V1::PokemonsController < ApplicationController
    def index
        @pokemons = Pokemon.paginate :page => params[:page]

        respond_to do |format|
            format.json {
                render :json => {
                    :current_page => @pokemons.current_page,
                    :next_page => @pokemons.next_page,
                    :previous_page => @pokemons.previous_page,
                    :per_page => @pokemons.per_page,
                    :total_pokemon => @pokemons.total_entries,
                    :pokemon => @pokemons
                }
            }
        end
    end

    def show
        @pokemon = Pokemon.find(params[:id])
    end

    def update
        if @pokemon.update(pokemon_params)
            render :show
        else
            render_error
        end
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

    def render_error
        render json: { errors: @pokemon.errors.full_messages },
            status: :unprocessable_entity
    end

    def pokemon_params
        params.require(:pokemon).permit(:number, :name, :type_1, :type_2, :total, :hp, :attack, :defense, :sp_atk, :sp_def, :speed, :generation, :legendary)
    end
end