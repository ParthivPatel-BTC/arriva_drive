class ParticipantsController < Devise::RegistrationsController
  before_filter :find_participant_from_params, only: [ :show, :edit, :update ]

  def show
  end

  def edit
    render file: 'participants/edit'
  end

  def update
    if @participant.update_attributes(activity_params)
      flash[:notice] = t('admin.msg.success.update', name: @participant.full_name)
      redirect_to show_participant_path(@participant)
    end
  end

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
