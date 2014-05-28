class Participant::HomeController < ApplicationController
  layout 'participant'
  before_filter :participant_user_required!

  def welcome
    render :welcome
  end
  alias :dashboard :welcome
end
