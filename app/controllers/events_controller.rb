class EventsController < ApplicationController
  before_filter :set_behaviours, only: [:new, :create, :show, :edit, :update]

  def new
    @event = Event.new
  end

  def create
    @event = Event.create(event_params)
    if @event.persisted?
      flash[:notice] = t('admin.msg.success.creation', name: @event.title)
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
  end

  private

  def event_params
    params.require(:event).permit(
      :title, :location, :event_date, :link, :description, :image,
      behaviours_events_attributes: [:id, :behaviour_id]
    )
  end
end
