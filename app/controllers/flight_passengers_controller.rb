class FlightPassengersController < ApplicationController

  def destroy
    ticket = FlightPassenger.find_by(flight_id: params[:flight], passenger_id: params[:passenger])
    ticket.destroy

    redirect_to '/flights'
  end
end
