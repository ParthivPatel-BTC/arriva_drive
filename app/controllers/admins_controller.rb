class AdminsController < ApplicationController
  before_filter :admin_user_required!

  def admin_panel
    @participants = Participant.all
    @activities   = Activity.all
    @events       = Event.all
    render 'admin_panel'
  end

  def overview
  	@participant = Participant.find(params[:id])
  	@behaviours = @participant.scores.collect { |score| score.behaviour }
  end

  alias :dashboard :admin_panel
end
