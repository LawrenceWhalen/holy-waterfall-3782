require 'rails_helper'

RSpec.describe 'removing a passenger from a flight' do
  before :each do
    @airline_1= Airline.create!(name: 'Terminal')
    @airline_2= Airline.create!(name: 'May Day')
    @flight_1 = @airline_1.flights.create!(number: '1999', date: '08/06/2021', departure_city: 'Denver', arrival_city: 'Tokyo')
    @flight_2 = @airline_1.flights.create!(number: '1998', date: '08/05/2021', departure_city: 'Denver', arrival_city: 'Toronto')
    @flight_3 = @airline_2.flights.create!(number: '2000', date: '09/06/2021', departure_city: 'Toronto', arrival_city: 'Tokyo')
    @passenger_1 = Passenger.create!(name: 'Alice', age: 34)
    @passenger_2 = Passenger.create!(name: 'Bob', age: 45)
    @passenger_3 = Passenger.create!(name: 'Judice', age: 67)
    @passenger_4 = Passenger.create!(name: 'Wanda', age: 12)
    FlightPassenger.create!(flight: @flight_1, passenger: @passenger_1)
    FlightPassenger.create!(flight: @flight_1, passenger: @passenger_4)
    FlightPassenger.create!(flight: @flight_2, passenger: @passenger_2)
    FlightPassenger.create!(flight: @flight_3, passenger: @passenger_3)
    FlightPassenger.create!(flight: @flight_3, passenger: @passenger_4)
    FlightPassenger.create!(flight: @flight_3, passenger: @passenger_1)

    visit '/flights'
  end

  it 'has a button to remove a passenger from a flight' do
    within("##{@flight_1.id}") do
      expect(page).to have_button('Remove From Flight', count: 2)
    end
    within("##{@flight_2.id}") do
      expect(page).to have_button('Remove From Flight', count: 1)
    end
    within("##{@flight_3.id}") do
      expect(page).to have_button('Remove From Flight', count: 3)
    end
  end
end
