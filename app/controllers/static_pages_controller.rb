class StaticPagesController < ApplicationController
  def index
    if current_participant
      redirect_to participant_dashboard_path and return
    end
    redirect_to new_participant_session_path and return
  end

  def admin
    if current_admin
      redirect_to admin_dashboard_path and return
    end
    redirect_to new_admin_session_path and return
  end

  def new_participant
  end

  def show
  end
end
