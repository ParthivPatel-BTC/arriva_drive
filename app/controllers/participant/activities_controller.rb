class Participant::ActivitiesController < ApplicationController
  layout 'participant'

  def index
    respond_to do |format|
      if params[:page] && !params[:behaviour_id].present?
        @activities = Activity.page(params[:page]).per(Settings.participants.pagination.per_page).order('title ASC')
        format.js{
        render file: 'participant/activities/index'
      }
      elsif params[:behaviour_id]
        if params[:behaviour_id].present?
          @activities = Activity.find_activities_by_behaviour_id(split_params_for_filter(params[:behaviour_id])).page(params[:page]).per(Settings.participants.pagination.per_page)
        else
          @activities = Activity.page(params[:page]).per(Settings.participants.pagination.per_page).order('title ASC')
        end
        format.js{
        render file: 'participant/activities/index'
      }
      elsif params[:behaviour_id] && params[:page]
        @activities = Activity.find_activities_by_behaviour_id(split_params_for_filter(params[:behaviour_id])).page(params[:page]).per(Settings.participants.pagination.per_page)
        format.js{
        render file: 'participant/activities/index'
      }
      else
      @activities = Activity.page(params[:page]).per(Settings.participants.pagination.per_page).order('title ASC')
        format.html
      end
    end
  end

  private

  def split_params_for_filter(params)
    params.split(',')
  end
end