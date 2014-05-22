class Participant::ActivitiesController < ApplicationController
  layout 'participant'
  before_filter :participant_user_required!

  def index
    respond_to do |format|
      @activities = Activity.get_activities(params)
      if params[:page] || params[:behaviour_id].present?
        format.js{
        render file: 'participant/activities/index'
      }
      else
        @activities = Activity.get_activities_for_pagination(params)
        format.js{
        render file: 'participant/activities/index'
      }
      format.html
      end
    end
  end

  def show
    @activity = Activity.find_by_id(params[:id])
    @mcq = @activity.multiple_choice_question
  end
end