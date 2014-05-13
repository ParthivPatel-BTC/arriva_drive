class ParticipantsController < Devise::RegistrationsController
  before_filter :find_participant_from_params, only: [ :show ]

  def show
  end

  protected

  def after_sign_up_path_for(resource)
    show_participant_path(resource)
  end

  def find_participant_from_params
    @participant = Participant.find(params[:id])
  end
end
