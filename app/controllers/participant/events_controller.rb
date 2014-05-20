class Participant::EventsController < ApplicationController
  layout 'participant'
  before_filter :participant_user_required!

  def index
    @events = Event.order('event_date DESC')
  end
end