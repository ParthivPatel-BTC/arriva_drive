class Participant::ActivitiesController < ApplicationController
  layout 'participant'

  def index
    @activities = Activity.page(params[:page]).per(Settings.participants.pagination.per_page).order('title ASC')
  end
end