require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'validations' do
    it {should have_many :flights}
  end
end
