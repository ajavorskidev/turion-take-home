class MissionsController < ApplicationController
  def index
    @missions = Mission.where(email: current_user.email)

    render json: @missions
  end

  def show
    @mission = Mission.where(id: params[:id], email: current_user.email)[0]

    if @mission.nil?
      render status: :not_found
    else
      render json: @mission
    end
  end

  def create
    @mission = Mission.create(name: params[:name], status: "Planned",
                              latitude: params[:latitude], longitude: params[:longitude],
                              altitude: params[:altitude], email: current_user.email)

    render json: @mission
  end

  def update
    @mission = Mission.where(id: params[:id], email: current_user.email)[0]

    render json: @mission, status: @mission.update_parameters(params)
  end

  def destroy
    @mission = Mission.where(id: params[:id], email: current_user.email)[0]

    if @mission.nil?
      render status: :not_found
    else
      @mission.destroy
      render json: "#{@mission.name} has been canceled", status: :ok
    end
  end
end
