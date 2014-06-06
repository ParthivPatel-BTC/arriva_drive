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
      send_invitation(@participant.password)
      redirect_to admin_dashboard_path
    else
      enhance_error_msg(@participant)
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
      if params[:send_invitation]
        @unique_passsword = Participant.generate_unique_passowrd
        send_invitation(@unique_passsword)
        @participant.update_attribute(:password, @unique_passsword)
      end
      redirect_to show_participant_path(@participant)
    else
      enhance_error_msg(@participant)
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
    @unique_passsword = Participant.generate_unique_passowrd
    if @participant.update_attribute(:password, @unique_passsword)
      @participant.send_invitation_to_participant(@unique_passsword)
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
      :first_name, :last_name, :job_title, :division, :year_started, :photo, :performance_summary, :email,
        scores_attributes:[:id, :scorable_id, :score, :scorable_type]
    )
  end

  def send_invitation(password)
    @participant.send_invitation_to_participant(password) if params[:send_invitation]
  end

  def enhance_error_msg(instence)
    if instence.errors[:photo_file_size].present?
      instence.errors.delete(:photo_file_size)
      instence.errors.delete(:photo)
      instence.errors.add('error:', 'File size too large, please choose a different file.')
    end
  end
end
