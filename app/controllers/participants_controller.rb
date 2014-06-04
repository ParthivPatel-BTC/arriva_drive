class ParticipantsController < Devise::RegistrationsController
  before_filter :find_participant_from_params, only: [ :show, :edit, :update, :deactivate, :activate, :resend_invitation]
  skip_before_filter :authenticate_scope!, :only => [:edit, :update, :destroy, :deactivate, :activate]
  before_filter :admin_user_required!, only: [:new, :create, :show, :edit, :update, :deactivate, :activate]

  def new
    @participant = Participant.new
  end

  def create
    @participant = Participant.new(activity_params)
    if @participant.save
      send_invitation(params[:participant])
      redirect_to admin_dashboard_path
    else
      @participant.errors.delete(:photo_file_size)
      render :new
    end
  end

  def show
  end

  def edit
    render file: 'participants/edit'
  end

  def update
    if @participant.update_attributes(activity_params)
      send_invitation(params[:participant])
      redirect_to show_participant_path(@participant)
    else
      @participant.errors.delete(:photo_file_size)
      render 'edit'
    end
  end

  def deactivate
    @participant.deactivate!
    redirect_to admin_dashboard_path
  end

  def activate
    @participant.activate!
    redirect_to admin_dashboard_path
  end

  def resend_invitation
    if @participant.send_invitation_to_participant(nil)
      redirect_to admin_dashboard_path
    end
  end
  protected

  def after_sign_in_path_for(resource)
    show_participant_path(resource)
  end

  def after_sign_up_path_for(resource)
    show_participant_path(resource)
  end

  def find_participant_from_params
    @participant = Participant.find(params[:id])
  end

  def activity_params
    params.require(:participant).permit(
      :first_name, :last_name, :job_title, :division, :year_started, :photo, :performance_summary, :email, :password, :password_confirmation,
        scores_attributes:[:id, :scorable_id, :score, :scorable_type]
    )
  end

  def send_invitation(participant)
    @participant.send_invitation_to_participant(participant[:password]) if params[:send_invitation]
  end
end
