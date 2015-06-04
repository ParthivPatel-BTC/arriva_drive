class Participant::EventsController < ApplicationController
  layout 'participant'
  before_filter :participant_user_required!
  before_filter :find_month_wise_events

  def index
    respond_to do |format|
      if current_participant.cohort.present?
        @events = Kaminari.paginate_array(current_participant.cohort.events).page(params[:page]).per(Settings.pagination.events_per_page)
      else
        @events = nil
      end
      if params[:page].present?
        format.js {
          render file: 'participant/events/index'
        }
      else
        format.html
      end
    end
  end

  def get_monthly_events
    respond_to do |format|
      if current_participant.cohort.present?
        @events = current_participant.cohort.events.active.get_monthly_events(params[:month]).page(params[:page]).per(Settings.pagination.events_per_page).order('event_date DESC, event_start_time DESC')
      else
        @events = nil
      end  
          format.js{
          render file: 'participant/events/index'
        }
    end
  end

  def find_month_wise_events
    if current_participant.cohort.present?
      @month_arr = current_participant.cohort.events.active.inject([]) do |arr, event|
        arr << event.event_date.strftime("%B")
      end
      @month_arr.uniq!
    else
      @month_arr = nil
    end
  end

  def publish
    @event = Event.find_by_id(params[:id])
    respond_to do |format|
      format.ics do
        calendar = Icalendar::Calendar.new
        calendar.add_event(@event.to_ics)
        calendar.publish
        render :text => calendar.to_ical, :layout => false
      end
    end
  end
end