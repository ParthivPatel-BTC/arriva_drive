class EventsController < ApplicationController
  before_filter :set_behaviours, only: [:new, :create, :show, :edit, :update]
  before_filter :find_set_event, only: [:edit, :update, :show, :publish]
  before_filter :admin_user_required!

  def new
    @event = Event.new
  end

  def create
    @event = Event.create(event_params)
    if @event.persisted?
      redirect_to admin_dashboard_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    processed_params = mark_nested_attr_for_destroy(event_params, 'behaviours_events_attributes', 'behaviour_id')
    if @event.update_attributes(processed_params)
      redirect_to admin_dashboard_path
    else
      render :edit
    end
  end

  def publish
    respond_to do |format|
      format.ics do
        calendar = Icalendar::Calendar.new
        calendar.add_event(@event.to_ics)
        calendar.publish
        render :text => calendar.to_ical, :layout => false
      end
    end
  end

  private

  def event_params
    params.require(:event).permit(
      :title, :location, :event_date, :event_time, :link, :description,
      behaviours_events_attributes: [:id, :behaviour_id]
    )
  end

  def find_set_event
    @event = Event.find_by_id(params[:id])
  end
end
