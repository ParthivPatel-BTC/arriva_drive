class Participant::ParticipantAttachmentsController < ApplicationController
  layout 'participant'
  before_filter :get_participant_attachments, only: [ :index ]

  def index
  end

  def create
    @attachment = ParticipantAttachment.new(activity_params)
    if @attachment.present?
      @attachment.save
      redirect_to participant_attachments_path
    else
      render :index
    end
  end

  private

  def activity_params
    params.require(:participant_attachments).permit(
      :participant_id, :attachment
    )
  end

  def get_participant_attachments
    @attachments = ParticipantAttachment.attachments(current_participant.id)
  end

end
