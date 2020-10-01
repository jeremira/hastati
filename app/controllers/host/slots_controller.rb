# frozen_string_literal: true

module Host
  class SlotsController < HostController
    def index
      @slots = current_user.slots
    end

    def create
      slot = current_user.slots.build slot_params
      if slot.save
        redirect_to host_slots_path, notice: 'Slot created'
      else
        redirect_to host_slots_path, alert: 'Slot not created'
      end
    end

    private

    def slot_params
      params.require(:slot).permit(:scheduled_at, :daytime, :max_people)
    end
  end
end
