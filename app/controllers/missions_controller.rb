class MissionsController < ApplicationController
  def index
    @missions = Mission.all

    render json: @missions
  end

  def show
    @mission = Mission.find(params[:id])

    render json: @mission
  end

  def create
    @mission = Mission.create(name: params[:name], status: "Planned",
                              latitude: params[:latitude], longitude: params[:longitude],
                              altitude: params[:altitude])

    render json: @mission
  end

  def update
    @mission = Mission.find(params[:id])

    if @mission.status == "Planned"
      params[:mission].each do |key, value|
        @mission[key] = value
      end
      @mission.save
    else
      @mission.update(status: params[:status])
    end
    render json: "#{@mission.name}'s has been updated successfully"
  end

  def destroy
    @mission = Mission.find(params[:id])
    @mission.destroy

    render json: "#{@mission.name} has been canceled"
  end
end
