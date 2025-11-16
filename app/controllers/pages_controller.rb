class PagesController < ApplicationController
  def home
  end

  def rooms
    @casas = Casa.all
  end

  def tours
  end

  def booking
    @casas = Casa.all
  end
end
