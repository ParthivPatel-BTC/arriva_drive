class ParticipantsController < Devise::RegistrationsController
  before_filter :find_participant_from_params, only: [ :show, :edit, :update, :deactivate, :activate ]
  skip_before_filter :authenticate_scope!, :only => [:edit, :update, :destroy, :deactivate, :activate]
  before_filter :admin_user_required!, only: [:new, :create, :show, :edit, :update, :deactivate, :activate]
  before_filter :participant_user_required!, only: [:welcome, :dashboard]
  layout 'participant', only: [:welcome, :dashboard]

  def new
    @participant = Participant.new
  end

  def create
    @participant = Participant.new(activity_params)
    if @participant.save
      flash[:notice] = t('admin.msg.success.update', name: @participant.full_name)
      redirect_to admin_dashboard_path
    else
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
      flash[:notice] = t('admin.msg.success.update', name: @participant.full_name)
      redirect_to show_participant_path(@participant)
    else
      render 'edit'
    end
  end

  def deactivate
    @participant.deactivate!
    flash[:notice] = t('admin.participant.msg.success.deactivated', name: @participant.full_name)
    redirect_to admin_dashboard_path
  end

  def activate
    @participant.activate!
    flash[:notice] = t('admin.participant.msg.success.activated', name: @participant.full_name)
    redirect_to admin_dashboard_path
  end

  def welcome
    render :welcome
  end
  alias :dashboard :welcome

  protected

  def after_sign_in_path_for(resource)
    show_participant_path(resource)
  end

  def after_sign_up_path_for(resource)
    flash[:notice] = t('admin.msg.success.creation', name: resource.full_name)
    show_participant_path(resource)
  end

  def find_participant_from_params
    @participant = Participant.find(params[:id])
  end

  def activity_params
    params.require(:participant).permit(
      :first_name, :last_name, :job_title, :division, :year_started, :photo, :performance_summary, :email, :password, :password_confirmation,
        scores_attributes:[:id, :behaviour_id, :score]
    )
  end
end
