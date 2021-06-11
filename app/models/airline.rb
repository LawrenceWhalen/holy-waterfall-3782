class Airline < ApplicationRecord
  has_many :flights

  def airline_passengers
    flights.joins(:passengers).where('passengers.age > 17').select('passengers.*').order('passengers.id').distinct
  end

end
