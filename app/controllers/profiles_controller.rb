# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @profile = current_user.profile || current_user.create_profile
  end

  def edit
    @profile = current_user.profile || current_user.create_profile
  end

  def update
    if current_user.profile&.update profile_params.to_h
      redirect_to profile_path, notice: 'Account information saved..'
    else
      redirect_to profile_path, alert: 'Account information not saved.'
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:lastname, :firstname, :street, :city, :zipcode, :country)
  end
end
