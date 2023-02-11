class Mission < ApplicationRecord
  def update_parameters(params)
    if status == "Planned"
      params[:mission].each { |key, value| self[key] = value }

      save
    else

      # For demo and testing sake, method exists to add images to a "successful mission"
      complete_mission(params[:status])

      response_code = 400 unless params[:status] && params[:mission].keys.count == 1

      update(status: params[:status]) unless response_code == 400
    end
    response_code
  end

  def complete_mission(status)
    update(image: "dog-3.jpg") if status == "Successful"
  end
end
