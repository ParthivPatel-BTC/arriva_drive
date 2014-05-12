class AdminsController < ApplicationController
  def admin_panel
    @participants = Participant.all
    @activities   = Activity.all
    @events       = Event.all
    render 'admin_panel'
  end

  alias :dashboard :admin_panel
end
