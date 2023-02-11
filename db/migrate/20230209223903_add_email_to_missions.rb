class AddEmailToMissions < ActiveRecord::Migration[7.0]
  def change
    add_column :missions, :email, :string
  end
end
