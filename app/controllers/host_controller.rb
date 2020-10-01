# frozen_string_literal: true

class HostController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_host!

  private

  def authorize_host!
    redirect_to root_path, alert: 'You can not access this page.' unless current_user.host?
  end
end
