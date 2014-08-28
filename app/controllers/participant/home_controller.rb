class Participant::HomeController < ApplicationController
  layout 'participant'
  before_filter :find_participant_from_params, only: [ :edit_profile, :update_profile ]
  before_filter :participant_user_required!

  def welcome
    render :welcome
  end
  alias :dashboard :welcome

  def edit_profile
  end

  def update_profile
    params[:participants][:notes_notification] = params[:participants][:notes_notification].present? ? true : false
    params[:participants][:files_notification] = params[:participants][:files_notification].present? ? true : false
    params[:participants][:network_notification] = params[:participants][:network_notification].present? ? true : false

    if params[:participants][:photo].present? && (!@password_confirmation.present? && (@password.present? || !@password.present?))
      if photo_check?
        @participant.update_attributes(activity_params)
        redirect_to participant_dashboard_path
      else
      render :edit_profile
    end

    elsif (params[:participants][:notes_notification] || !params[:participants][:notes_notification]) && (!@password_confirmation.present? && !@password.present?)
      @participant.update_attributes(activity_params)
      sign_in(@participant, :bypass => true)
      redirect_to participant_dashboard_path

    elsif (params[:participants][:files_notification] || !params[:participants][:files_notification]) && (!@password_confirmation.present? && !@password.present?)
      @participant.update_attributes(activity_params)
      sign_in(@participant, :bypass => true)
      redirect_to participant_dashboard_path

    elsif (params[:participants][:network_notification] || !params[:participants][:network_notification]) && (!@password_confirmation.present? && !@password.present?)
      @participant.update_attributes(activity_params)
      sign_in(@participant, :bypass => true)
      redirect_to participant_dashboard_path

    elsif !@password.present?
      @participant.errors.add(:password, "is required")
      render :edit_profile

    elsif @password.present?
      if password_match?
        if @participant.update_attributes(activity_params)
          sign_in(@participant, :bypass => true)
          redirect_to participant_dashboard_path
        else
         render :edit_profile
        end
      else
        render :edit_profile
      end
    else
      redirect_to participant_dashboard_path
    end
  end


  private

  def find_participant_from_params
    @participant = Participant.find(params[:id])
  end

  def activity_params
    params.require(:participants).permit(
      :password, :photo, :notes_notification, :files_notification, :network_notification
    )
  end

  def password_match?
    @password = params[:password]
    @password_confirmation = params[:participants][:password]

    if @password.present? && !@password_confirmation.present?
      @participant.errors.add(:password, "does not match with confirmed password")
      false
    elsif @password != @password_confirmation
      @participant.errors.add(:password, "does not match with confirmed password")
      false
    elsif @password.empty?
      @participant.errors.add(:password, "is required")
      return false
    else
      true
    end
  end

  def photo_check?
    if params[:participants][:photo].size > 3.megabytes
      @participant.errors.add(:photo, "should be less than 3MB")
      return false
    else
      return true
    end
  end
end