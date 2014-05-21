class Participant::ActivitiesController < ApplicationController
  layout 'participant'

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
end