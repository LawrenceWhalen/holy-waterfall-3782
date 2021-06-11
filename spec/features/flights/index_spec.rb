require 'rails_helper'

RSpec.describe 'flights index' do
  before :each do
    @airline_1= Airline.create!(name: 'Terminal')
    @airline_2= Airline.create!(name: 'May Day')
    @flight_1 = @airline_1.flights.create!(number: '1999', date: '08/06/2021', departure_city: 'Denver', arrival_city: 'Tokyo')
    @flight_2 = @airline_1.flights.create!(number: '1998', date: '08/05/2021', departure_city: 'Denver', arrival_city: 'Toronto')
    @flight_3 = @airline_2.flights.create!(number: '2000', date: '09/06/2021', departure_city: 'Toronto', arrival_city: 'Tokyo')

    visit '/flights'
  end

      # When I visit the flights index page
      # I see a list of all flight numbers
      # And next to each flight number I see the name of the Airline of that flight
      # And under each flight number I see the names of all that flight's passengers

  describe 'visit' do
    it 'shows all flight numbers' do
      expect(page).to have_content(@flight_1.number)
      expect(page).to have_content(@flight_2.number)
      expect(page).to have_content(@flight_3.number)
    end

    it 'displays airline names next to flights' do
      within("##{@flight_1.id}") do
        expect(page).to have_content(@airline_1.name)
      end
      within("##{@flight_2.id}") do
        expect(page).to have_content(@airline_1.name)
      end
      within("##{@flight_3.id}") do
        expect(page).to have_content(@airline_2.name)
      end
    end
  end
end
