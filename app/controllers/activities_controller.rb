class ActivitiesController < ApplicationController
  before_filter :set_behaviours, only: [:new, :create, :show, :edit, :update]
  before_filter :set_cohorts, only: [:new, :create, :show, :edit, :update]
  before_filter :find_set_activity, only: [:edit, :update, :show]
  before_filter :admin_user_required!

  def new
    @activity = Activity.new
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
    processed_params = mark_nested_attr_for_destroy(activity_params, 'cohort_activities_attributes', 'cohort_id')
    if @activity.update_attributes(processed_params)
      redirect_to admin_dashboard_path
    else
      render :edit
    end
  end

  private

  def build_nested_mcq_resource
    @activity.build_multiple_choice_question if @activity.multiple_choice_question.blank?
  end

  def activity_params
    if params[:activity][:activity_type] == 5
      params.require(:activity).permit(
          :behaviour_id, :title, :link, :activity_type, :description, :online_course_image, cohort_activities_attributes:[:id, :cohort_id])
    else
      params.require(:activity).permit(
          :behaviour_id, :title, :link, :activity_type, :description, :online_course_image,
          multiple_choice_question_attributes: [
              :id, :question_text, answers_attributes: [:id, :answer_text, :correct],
            ], cohort_activities_attributes:[:id, :cohort_id]
      )
    end
  end

  def find_set_activity
    @activity = Activity.find_by_id(params[:id])
    @activity_present_in_conhorts = @activity.cohorts
  end
end
