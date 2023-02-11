class ImagesController < ApplicationController
  def show
    @mission = Mission.where(id: params[:id], email: current_user.email)[0]

    if @mission
      @image = Image.new(@mission)
      send_data @image.fetch_image, filename: "image", type: "image/jpeg", disposition: "inline"

    else
      render status: :not_found
    end
  end
end
