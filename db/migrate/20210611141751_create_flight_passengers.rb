class CreateFlightPassengers < ActiveRecord::Migration[5.2]
  def change
    create_table :flight_passengers do |t|
      t.references :passengers, foreign_key: true
      t.references :flights, foreign_key: true

      t.timestamps
    end
  end
end
