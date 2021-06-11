require 'rails_helper'

RSpec.describe 'flights index' do
  before :each do
    @airline_1= Airline.create!(name: 'Terminal')
    @flight_1 = @airline_1.flights.create!(number: '1999', date: '08/06/2021', departure_city: 'Denver', arrival_city: 'Tokyo')
    @flight_2 = @airline_1.flights.create!(number: '1998', date: '08/05/2021', departure_city: 'Denver', arrival_city: 'Toronto')
    @flight_3 = @airline_1.flights.create!(number: '2000', date: '09/06/2021', departure_city: 'Toronto', arrival_city: 'Tokyo')
    @passenger_1 = Passenger.create!(name: 'Alice', age: 34)
    @passenger_2 = Passenger.create!(name: 'Bob', age: 45)
    @passenger_3 = Passenger.create!(name: 'Judice', age: 67)
    @passenger_4 = Passenger.create!(name: 'Wanda', age: 12)
    FlightPassenger.create!(flight: @flight_1, passenger: @passenger_1)
    FlightPassenger.create!(flight: @flight_2, passenger: @passenger_2)
    FlightPassenger.create!(flight: @flight_3, passenger: @passenger_3)
  end

    # Then I see a list of passengers that have flights on that airline
    # And I see that this list is unique (no duplicate passengers)
    # And I see that this list only includes adult passengers
    #
    # (Note: an adult is anyone with age greater than or equal to 18)

  describe 'visit' do
    it 'shows all passengers on that airlines flights' do
      visit "/airlines/#{@airline_1.id}"

      expect(page).to have_content(@passenger_1.name)
      expect(page).to have_content(@passenger_2.name)
      expect(page).to have_content(@passenger_3.name)
    end
    it 'has no duplicate passengers' do
      FlightPassenger.create!(flight: @flight_1, passenger: @passenger_3)
      FlightPassenger.create!(flight: @flight_2, passenger: @passenger_2)
      FlightPassenger.create!(flight: @flight_3, passenger: @passenger_1)
      visit "/airlines/#{@airline_1.id}"

      expect(page).to have_content(@passenger_1.name, count: 1)
      expect(page).to have_content(@passenger_2.name, count: 1)
      expect(page).to have_content(@passenger_3.name, count: 1)
    end
    it 'has no names of minors' do
      FlightPassenger.create!(flight: @flight_1, passenger: @passenger_4)
      visit "/airlines/#{@airline_1.id}"

      expect(page).to_not have_content(@passenger_4.name)
    end
    it 'is sorted by number of flights' do
      FlightPassenger.create!(flight: @flight_1, passenger: @passenger_3)
      FlightPassenger.create!(flight: @flight_2, passenger: @passenger_2)
      FlightPassenger.create!(flight: @flight_2, passenger: @passenger_3)

      expect(@passenger_3.name).to appear_before(@passenger_2.name)
      expect(@passenger_2.name).to appear_before(@passenger_1.name)
    end
  end
end
