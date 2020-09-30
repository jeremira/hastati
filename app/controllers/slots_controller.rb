# frozen_string_literal: true

class SlotsController < ApplicationController
  before_action :authenticate_user!

  def index
    @slots = current_user.slots
  end

  def create
    slot = current_user.slots.build slot_params
    if slot.save
      redirect_to slots_path, notice: 'Slot created'
    else
      redirect_to slots_path, alert: 'Slot not created'
    end
  end

  private

  def slot_params
    params.require(:slot).permit(:scheduled_at, :daytime, :max_people)
  end
end
