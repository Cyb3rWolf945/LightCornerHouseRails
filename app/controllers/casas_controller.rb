class CasasController < ApplicationController
    def show
      @casa = Casa.includes(:fotos).find(params[:id])
    end
  end
  