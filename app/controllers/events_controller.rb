# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = Slot.bookable_for(current_user).includes(:user)
  end
end
