require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'validations' do
    it {should have_many :flights}
  end

  describe 'instance methods' do
    describe '.airline_passengers' do
      it 'returns a unique list of all passengers with flights on that airline' do
        @airline_1= Airline.create!(name: 'Terminal')
        @flight_1 = @airline_1.flights.create!(number: '1999', date: '08/06/2021', departure_city: 'Denver', arrival_city: 'Tokyo')
        @flight_2 = @airline_1.flights.create!(number: '1998', date: '08/05/2021', departure_city: 'Denver', arrival_city: 'Toronto')
        @flight_3 = @airline_1.flights.create!(number: '2000', date: '09/06/2021', departure_city: 'Toronto', arrival_city: 'Tokyo')
        @passenger_1 = Passenger.create!(name: 'Alice', age: 34)
        @passenger_2 = Passenger.create!(name: 'Bob', age: 45)
        @passenger_3 = Passenger.create!(name: 'Judice', age: 67)
        @passenger_4 = Passenger.create!(name: 'Wanda', age: 12)
        FlightPassenger.create!(flight: @flight_1, passenger: @passenger_1)
        FlightPassenger.create!(flight: @flight_1, passenger: @passenger_3)
        FlightPassenger.create!(flight: @flight_2, passenger: @passenger_1)
        FlightPassenger.create!(flight: @flight_2, passenger: @passenger_2)
        FlightPassenger.create!(flight: @flight_3, passenger: @passenger_3)
        FlightPassenger.create!(flight: @flight_3, passenger: @passenger_1)

        expect(@airline_1.airline_passengers.first.name).to eq('Alice')
      end
    end
  end
end
