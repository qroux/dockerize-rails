class CarsController < ApplicationController
  def index
    @cars = Car.all
  end

  def show
    find_car
  end

  private

  def find_car
    @car = Car.find(params[:id])
  end
end
