# frozen_string_literal: true

class SlotsController < ApplicationController
  before_action :authenticate_user!

  def index
    @slots = current_user.slots
  end
end
