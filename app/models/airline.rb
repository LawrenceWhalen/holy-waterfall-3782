class Airline < ApplicationRecord
  has_many :flights

  def airline_passengers
    flights.joins(:passengers).where('passengers.age > 17').select('passengers.*, count(passengers.id) as flight_count').group('passengers.id').order('flight_count desc')
  end

end
