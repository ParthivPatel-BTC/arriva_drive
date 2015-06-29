class Participant::EventsController < ApplicationController
  layout 'participant'
  before_filter :participant_user_required!
  # before_filter :find_month_wise_events

  def index
    respond_to do |format|
      if current_participant.cohort.present?
        @first_month = Date.today.month.even? ? Date.today.month - 1 : Date.today.month
        @second_month = Date.today.month.odd? ? Date.today.month + 1 : Date.today.month
        @first_month_name = Date::MONTHNAMES[@first_month]
        @second_month_name = Date::MONTHNAMES[@second_month]
        @event_year = Date.today.year

        current_participant_events = current_participant.cohort.events
        @events_by_first_month = current_participant_events.events_by_month(@first_month)
        @events_by_second_month = current_participant_events.events_by_month(@second_month)
        find_months_with_year(current_participant_events)
      end
        format.html
    end
  end

  def get_monthly_events
    respond_to do |format|
      if current_participant.cohort.present?
        current_participant_events = current_participant.cohort.events
        @first_month_name = params[:first_month]
        @second_month_name = params[:second_month]
        @event_year = params[:year]
        @events_by_first_month = current_participant_events.search_events_by_month_year(@first_month_name, params[:year])
        @events_by_second_month = current_participant_events.search_events_by_month_year(@second_month_name, params[:year])
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

  def find_months_with_year(events)
    # events_months_with_year = (events.order(event_date: :asc).first.event_date.beginning_of_month..events.order(event_date: :desc).first.event_date.end_of_month).map{ |m| m.strftime('%Y%B') }.uniq.map{ |m| m << Date::ABBR_MONTHNAMES[ Date.strptime(m, '%Y%B').mon ] }
    events_months_with_year = (events.order(event_date: :asc).first.event_date.beginning_of_month..events.order(event_date: :desc).first.event_date.end_of_month).map{ |m| m.strftime('%Y%B') }.uniq
    @events_months_with_year = events_months_with_year.each_slice(2).to_a
  end
end