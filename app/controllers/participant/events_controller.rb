class Participant::EventsController < ApplicationController
  layout 'participant'
  before_filter :participant_user_required!
  before_filter :find_month_wise_events

  def index
    respond_to do |format|
      @events = Event.page(params[:page]).per(Settings.pagination.events_per_page).order('event_date DESC')
      if params[:page].present?
        format.js{
        render file: 'participant/events/index'
      }
      else
      format.html
      end
    end
  end

  def find_month_wise_events
    @month_arr = Event.all.inject([]) do |arr, event|
      arr << event.event_date.strftime("%B")
    end
    @month_arr.uniq!
  end
end