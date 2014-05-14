class ActivitiesController < ApplicationController
  before_filter :set_behaviours, only: [:new, :create, :show, :edit, :update]
  before_filter :find_set_activity, only: [:edit, :update, :show]

  def new
    @activity   = Activity.new
  end

  def create
    @activity = Activity.create(activity_params)
    if @activity.persisted?
      flash[:notice] = t('admin.msg.success.creation', name: @activity.title)
      redirect_to admin_dashboard_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @activity.update_attributes(activity_params)
    flash[:notice] = t('admin.msg.success.update', name: @activity.title)
    redirect_to admin_dashboard_path
  end

  private

  def activity_params
    params.require(:activity).permit(
      :behaviour_id, :title, :link, :activity_type, :description,
      multiple_choice_question_attributes: [
        :id, :question_text, answers_attributes: [:id, :answer_text, :correct]
      ]
    )
  end

  def find_set_activity
    @activity = Activity.find_by_id(params[:id])
  end
end
