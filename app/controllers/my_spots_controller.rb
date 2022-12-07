class MySpotsController < ApplicationController
  def index
    @fav_surf_spots = current_user.favorite_spots.where(sport: "surf")
    # @fav_run_spots = current_user.favorite_spots.where(sport: "running")
  end

  def create
    @fav_spot = FavoriteSpot.new(sport: "surf", user: current_user)
    @spot = Spot.find(params[:spot_id])
    @fav_spot.spot = @spot
    @fav_spot.save!
  end

end

