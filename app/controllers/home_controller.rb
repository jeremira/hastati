# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    redirect_to slots_path if current_user.host?
  end
end
