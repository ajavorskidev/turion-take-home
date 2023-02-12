class ImagesController < ApplicationController
  def show
    # Grab the mission corresponding to the mission id provided, and the user's email
    @mission = Mission.where(id: params[:id], email: current_user.email)[0]

    # Check whether a mission was found with the provided id and corresponding user email.
    if @mission
      # Initializes a new image object, in addition to initializing a new AWS S3 client
      @image = Image.new(@mission)

      # The S3 service call occurs in the fetch_image method, returning the image.
      send_data @image.fetch_image, filename: "image.jpg", type: "image/jpeg", disposition: "inline"

    else
      render status: :not_found
    end
  end
end
