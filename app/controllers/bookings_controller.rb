# frozen_string_literal: true

class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookings = current_user.bookings
  end

  def new
    @booking = current_user.bookings.build booking_params
  end

  def create
    @booking = current_user.bookings.build booking_params
    if @booking.slot.available? && @booking.save
      @booking.slot.booked!
      redirect_to bookings_path, notice: 'Event has been booked.'
    else
      redirect_to events_path, alert: 'Event could not be booked.'
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:slot_id, :people)
  end
end
