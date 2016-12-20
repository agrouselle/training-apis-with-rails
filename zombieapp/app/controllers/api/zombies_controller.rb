module API
  class ZombiesController < ApplicationController
    def index
      zombies = Zombie.all

      if params[:weapon]
        zombies = zombies.where(weapon: params[:weapon])
      end

      respond_to do |format|
        format.any(:json, :html) { render json: zombies, status: 200 }
        format.xml { render xml: zombies, status: 200 }
      end
    end

    def show
      @zombie = Zombie.find(params[:id])

      respond_to do |format|
        format.html { render json: @zombie }
        format.json
      end
    end
  end
end