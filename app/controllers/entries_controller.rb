class EntriesController < ApplicationController

  def new
    if @current_user == nil
      flash["notice"] = "You must be logged in to add an entry."
      redirect_to "/login"
    end
  end

  def create
    if @current_user
      @entry = Entry.new
      @entry["title"] = params["title"]
      if params["uploaded_image"]
        @entry.uploaded_image.attach(params["uploaded_image"])
      end
      @entry["description"] = params["description"]
      @entry["occurred_on"] = params["occurred_on"]
      @entry["place_id"] = params["place_id"]
      @entry["user_id"] = session["user_id"]
      @entry.save
      redirect_to "/places/#{@entry["place_id"]}"
    else
      flash["notice"] = "You must be logged in to add an entry."
      redirect_to "/login"
    end
  end

end
