class Mission < ApplicationRecord
  # Method that takes mission update parameters and updates the mission. Additionally,
  # checks whether a mission is allowed to have other parameters than status changed, and
  # returns a 400 status code if status is not "Planned" and other parameters than status
  # have been provided.
  def update_parameters(params)
    if status == "Planned"
      params[:mission].each { |key, value| self[key] = value }

      save
    else
      complete_mission(params[:status])

      response_code = 400 unless params[:status] && params[:mission].keys.count == 1

      update(status: params[:status]) unless response_code == 400
    end
    response_code
  end

  # For demo and testing sake, method exists to add images to a "successful mission"
  def complete_mission(status)
    update(image: "dog-3.jpg") if status == "Successful"
  end
end
