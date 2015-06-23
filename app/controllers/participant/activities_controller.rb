class Participant::ActivitiesController < ApplicationController
  require 'screen_scraping_service'
  layout 'participant'
  before_filter :participant_user_required!
  before_filter :find_set_activity, only: [:show, :new_review, :create_review, :answer_question]

  def index
    respond_to do |format|
      if current_participant.cohort.present?
        @activities = Activity.get_activities(params, current_participant.cohort.activities)
      else
        @activities = nil
      end
      format.js{
        render file: 'participant/activities/index'
      }
        # @mcq = @activity.multiple_choice_question if @activity.activity_type != 5
        # @activities = current_participant.cohort.activities.get_activities(params)
        # if params[:page] || params[:behaviour_id].present?
        #   format.js{
        #     render file: 'participant/activities/index'
        #   }
        # else
        #   @activities = current_participant.cohort.activities.get_activities_for_pagination(params)
      format.html
    end
  end

  def show
    @mcq = @activity.multiple_choice_question if @activity.activity_type != 5
    @activity_image = ScreenScrapingService.fetch_data_from_web(@activity.link) if @activity.activity_type != 5
  end

  def new_review
    @review = Review.new
  end

  def create_review
    redirect to participant_activities_path unless params[:review][:review_text]
    @review = current_participant.reviews.create(review_params.merge({ activity_id: @activity.id }))
    if @review.persisted?
      flash[:notice] = t('participant.msg.success.review_creation')
      redirect_to participant_activities_path
    else
      render :new_review
    end
  end

  def answer_question
    @mcq = @activity.multiple_choice_question
    @activity_answer_participant = ActivityAnswerParticipant.create(
      activity_id: @activity.id,
      participant_id: current_participant.id,
      answer_id: params[:activity][:answer]
    )
    @popup_msg = if @activity_answer_participant.is_correct?
                   t('participant.msg.success.correct_answer', relevant: @activity.behaviour.title)
                 else
                   t('participant.msg.success.wrong_answer', relevant: @activity.behaviour.title)
                 end
  end

  private

  def find_set_activity
    @activity = Activity.find_by_id(params[:id])
  end

  def review_params
    params.require(:review).permit(:review_text)
  end
end
