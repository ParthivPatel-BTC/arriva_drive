class ActivitiesController < ApplicationController
  before_filter :set_behaviours, only: [:new, :create, :show, :edit, :update]
  before_filter :find_set_activity, only: [:edit, :update, :show]
  before_filter :admin_user_required!

  def new
    @activity   = Activity.new
    build_nested_mcq_resource
  end

  def create
    @activity = Activity.create(activity_params)
    if @activity.persisted?
      redirect_to admin_dashboard_path
    else
      build_nested_mcq_resource
      render :new
    end
  end

  def show
  end

  def edit
    build_nested_mcq_resource
  end

  def update
    @activity.update_attributes(activity_params)
    redirect_to admin_dashboard_path
  end

  private

  def build_nested_mcq_resource
    @activity.build_multiple_choice_question if @activity.multiple_choice_question.blank?
  end

  def activity_params
    if params[:activity][:activity_type] == 5
      params.require(:activity).permit(
          :behaviour_id, :title, :link, :activity_type, :description, :online_course_image
      )
    else
      params.require(:activity).permit(
          :behaviour_id, :title, :link, :activity_type, :description, :online_course_image,
          multiple_choice_question_attributes: [
              :id, :question_text, answers_attributes: [:id, :answer_text, :correct]
          ]
      )
    end
  end

  def find_set_activity
    @activity = Activity.find_by_id(params[:id])
  end
end
