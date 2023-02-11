class AddImageToMissions < ActiveRecord::Migration[7.0]
  def change
    add_column :missions, :image, :string
  end
end
