class CreateMissions < ActiveRecord::Migration[7.0]

  def change
    create_table :missions do |t|
      t.string :name
      t.string :status
      t.decimal :latitude
      t.decimal :longitude
      t.integer :altitude

      t.timestamps
    end
  end
end
