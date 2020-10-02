# frozen_string_literal: true

class GuestController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_guest!

  private

  def authorize_guest!
    redirect_to root_path, alert: 'You can not access this page.' unless current_user.guest?
  end
end
