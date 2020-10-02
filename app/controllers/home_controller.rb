# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to guest_events_path if current_user.guest?
    redirect_to host_slots_path if current_user.host?
  end
end
