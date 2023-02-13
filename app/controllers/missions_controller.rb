class MissionsController < ApplicationController
  # Returns a list of all missions corresponding to the current user.
  def index
    @missions = Mission.where(email: current_user.email)

    render json: @missions
  end

  # Returns a mission corresponding to the provided misison id, and which is
  # associated to the current user.
  def show
    @mission = Mission.where(id: params[:id], email: current_user.email)[0]

    if @mission
      render json: @mission
    else
      render status: :not_found
    end
  end

  # Creates and returns a newly created mission with the given parameters and
  # associated to the current user. Status is set by default to "Planned".
  def create
    @mission = Mission.create(name: params[:name], status: "Planned",
                              latitude: params[:latitude], longitude: params[:longitude],
                              altitude: params[:altitude], email: current_user.email)

    render json: @mission, status: :created
  end

  # Updates and returns the updated mission corresponding to the given mission id
  # and current user. Calls the update_parameters method to check whether a request
  # is valid and update the mission. update_parameters returns a status code 400 if
  # a request is invalid.
  def update
    @mission = Mission.where(id: params[:id], email: current_user.email)[0]

    if @mission
      render json: @mission, status: @mission.update_parameters(params)
    else
      render status: :not_found
    end
  end

  # Deletes the mission corresponding to the given mission id and current user.
  def destroy
    @mission = Mission.where(id: params[:id], email: current_user.email)[0]

    if @mission
      @mission.destroy
      render json: "#{@mission.name} has been canceled", status: :ok
    else
      render status: :not_found
    end
  end
end
