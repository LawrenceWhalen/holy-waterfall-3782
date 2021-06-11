require 'rails_helper'

RSpec.describe Passenger, type: :model do

  describe 'validations' do
    it { should have_many(:flight_passengers).dependent(:destroy) }
    it { should have_many(:flights).through(:flight_passengers) }
  end

end
