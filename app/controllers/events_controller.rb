class EventsController < ApplicationController
  before_filter :set_behaviours, only: [:new, :create, :show, :edit, :update]
  before_filter :find_set_event, only: [:edit, :update, :show]
  before_filter :admin_user_required!

  def new
    @event = Event.new
  end

  def create
    @event = Event.create(event_params)
    if @event.persisted?
      redirect_to admin_dashboard_path
    else
      @event.errors.delete(:image_file_size)
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
      @event.errors.delete(:image_file_size)
      render :edit
    end
  end

  private

  def event_params
    params.require(:event).permit(
      :title, :location, :event_date, :event_start_time, :event_end_time, :link, :description, :image,
      behaviours_events_attributes: [:id, :behaviour_id]
    )
  end

  def find_set_event
    @event = Event.find_by_id(params[:id])
  end
end
