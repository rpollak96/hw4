class PlacesController < ApplicationController

  def index
    if @current_user
      @places = Place.where({ "user_id" => @current_user["id"] })
    else
      @places = []
    end
  end

  def show
    @place = Place.find_by({ "id" => params["id"] })
    if @current_user && @place && @place["user_id"] == @current_user["id"]
      @entries = Entry.where({ "place_id" => @place["id"], "user_id" => @current_user["id"] })
    else
      # If place doesn't exist or doesn't belong to the user, don't show anything
      if @place && (@current_user == nil || @place["user_id"] != @current_user["id"])
        flash["notice"] = "You don't have access to that place."
        redirect_to "/places"
        return
      end
      @entries = []
    end
  end

  def new
    if @current_user == nil
      flash["notice"] = "You must be logged in to add a place."
      redirect_to "/login"
    end
  end

  def create
    if @current_user
      @place = Place.new
      @place["name"] = params["name"]
      @place["user_id"] = @current_user["id"]
      @place.save
      redirect_to "/places"
    else
      flash["notice"] = "You must be logged in to add a place."
      redirect_to "/login"
    end
  end

end
