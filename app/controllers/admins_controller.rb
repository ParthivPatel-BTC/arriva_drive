class AdminsController < ApplicationController
  def admin_panel
    @participants = Participant.all
    @activities   = Activity.all
    @events       = Event.all
    render 'admin_panel'
  end

  alias :dashboard :admin_panel

  def overview
  	@participant = Participant.find(params[:participant_id])
  	@behaviours = @participant.scores.collect { |score| score.behaviour }
  end
end
