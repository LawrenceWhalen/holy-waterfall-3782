require 'rails_helper'

RSpec.describe Flight, type: :model do

  describe 'validations' do
    it {should belong_to :airline}
    it { should have_many(:flight_passengers).dependent(:destroy) }
    it { should have_many(:passengers).through(:flight_passengers) }
  end

  describe 'instance methods' do
    describe '.airline_name' do
      it 'returns the name of that flights airline' do
        airline_1= Airline.create!(name: 'Terminal')
        flight_1 = airline_1.flights.create!(number: '1999', date: '08/06/2021', departure_city: 'Denver', arrival_city: 'Tokyo')

        expect(flight_1.airline_name).to eq('Terminal')
      end
    end
  end
end
