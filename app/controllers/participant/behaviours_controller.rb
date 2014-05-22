class Participant::BehavioursController < ApplicationController
  layout 'participant'
  before_filter :participant_user_required!

  def index
  end
end
