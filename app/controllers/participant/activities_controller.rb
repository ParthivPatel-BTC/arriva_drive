class Participant::ActivitiesController < ApplicationController
  layout 'participant'
  before_filter :participant_user_required!
  before_filter :find_set_activity, only: [:show, :new_review, :create_review, :answer_question]

  def index
    respond_to do |format|
      @activities = Activity.get_activities(params)
      if params[:page] || params[:behaviour_id].present?
        format.js{
        render file: 'participant/activities/index'
      }
      else
        @activities = Activity.get_activities_for_pagination(params)
        format.js{
        render file: 'participant/activities/index'
      }
      format.html
      end
    end
  end

  def show
    @mcq = @activity.multiple_choice_question
  end

  def new_review
    @review = Review.new
  end

  def create_review
    @review = current_participant.review.create(review_params)
    if @review.persisted?
      flash[:notice] = t('participant.msg.success.review_creation')
      redirect_to participant_activity_path(@participant)
    else
      render :new
    end
  end

  def answer_question
    
  end

  private

  def find_set_activity
    @activity = Activity.find_by_id(params[:id])
  end

  def review_params
    params.require(:review).permit(:review_text)
  end
end
