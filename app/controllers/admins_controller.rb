class AdminsController < ApplicationController
  before_filter :admin_user_required!

  def admin_panel
    @cohorts = Cohort.all.collect{|c| [c.name, c.id]}.insert(0, "All")
    if params[:id].present? && params[:id].to_i > 0
      @participants = Cohort.find(params[:id]).participants
      @events = Cohort.find(params[:id]).events
      @activities = Cohort.find(params[:id]).activities
    else
      @participants = Participant.all
      @events = Event.all
      @activities = Activity.all
    end
    respond_to do |format|
      format.js { render 'admin_panel' }
      format.html { render 'admin_panel' }
    end
  end

  def overview
  	@participant = Participant.find(params[:id])
  	@behaviours  = @participant.scores.behaviour_scores.collect { |score| score.scorable }
  end

  def overall_cohort_scores
    @behaviours = Behaviour.all
  end

  alias :dashboard :admin_panel
end