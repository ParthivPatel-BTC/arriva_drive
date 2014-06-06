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
    if @participant.update_attributes(activity_params)
      redirect_to participant_dashboard_path
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
end
