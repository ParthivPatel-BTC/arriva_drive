class Participant::ParticipantAttachmentsController < ApplicationController
  layout 'participant'
  before_filter :get_participant_attachments, only: [ :index, :destroy ]
  before_filter :find_attachment, only: [ :destroy ]

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

  def destroy
    respond_to do |format|
      @attachment.destroy
        format.js{
        render file: 'participant/participant_attachments/attachment'
      }
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

  def find_attachment
    @attachment = ParticipantAttachment.find_by_id(params[:id])
  end

end
