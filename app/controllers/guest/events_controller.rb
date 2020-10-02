# frozen_string_literal: true

module Guest
  class EventsController < GuestController
    def index
      @events = Slot.available.where('scheduled_at > ?', Time.zone.now).includes(:user)
    end
  end
end
