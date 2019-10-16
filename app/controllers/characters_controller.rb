class CharactersController < ApplicationController
    def new
        @character = Character.new
    end

    def create
        @character = Character.new(character_params)

        if @character.save
            redirect_to character_path(@character)
        else
            flash[:alert] = "Héro non valide ! Vérifie tes attributs."
            render :new
        end
    end

    def show
        @character = Character.find(params[:id])
    end

    private

    def character_params
        params.require(:character).permit(:name, :health, :attack, :speed, :dodge_rate, :critical_rate, :avatar)
    end
end
