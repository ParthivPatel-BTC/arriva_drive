class Participant::ActivitiesController < ApplicationController
  layout 'participant'

  def index
    @activities = Activity.page(params[:page]).per(Settings.participants.pagination.per_page).order('title ASC')
    respond_to do |format|
      if params[:page]
        format.js{
        render file: 'participant/activities/index'
      }
      elsif params[:behaviour_id]
        @activities = Activity.find_activities_by_behaviour_id(params[:behaviour_id]).page(params[:page]).per(Settings.participants.pagination.per_page)
        format.js{
        render file: 'participant/activities/index'
      }
      else
        format.html
      end
    end
  end
end