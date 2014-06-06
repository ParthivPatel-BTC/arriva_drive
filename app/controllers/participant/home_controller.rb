class Participant::HomeController < ApplicationController
  layout 'participant'
  before_filter :find_participant_from_params, only: [ :edit_profile, :update_profile ]
  before_filter :participant_user_required!

  def welcome
    render :welcome
  end
  alias :dashboard :welcome

  def edit_profile
    @participant = Participant.new
  end

  def update_profile
    if params[:password].present? && !params[:participants][:photo].present?
      password_match?
      @participant.update_attributes(activity_params)
      redirect_to participant_dashboard_path
    elsif params[:participants][:photo].present? && !params[:participants][:password].present?
      @participant.update_attributes(activity_params)
      redirect_to participant_dashboard_path
    elsif params[:participants][:photo].present? && params[:password].present?
      @participant.update_attributes(activity_params)
      redirect_to participant_dashboard_path
    else
      render :edit_profile
    end
  end

  private

  def find_participant_from_params
    @participant = Participant.find(params[:id])
  end

  def activity_params
    params.require(:participants).permit(
      :photo, :password
    )
  end

  def password_match?
    password = params[:password]
    password_confirmation = params[:participants][:password]
    if password != password_confirmation
      @participant.errors.add(:password, "does not match with confirmed password")
      false
    else
      true
    end
  end
end
