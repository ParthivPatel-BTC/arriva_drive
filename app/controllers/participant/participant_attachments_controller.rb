class Participant::ParticipantAttachmentsController < ApplicationController
  layout 'participant'
  before_filter :get_participant_attachments, only: [ :index, :destroy ]
  before_filter :find_attachment, only: [ :destroy, :shred_participants_list ]

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

  def shred_participants_list
    @participants = Network.all_participants_in_network(current_participant)
    @shared_participants = SharedAttachment.shared_attachment_participants(@attachment.id)
  end

  def create_shared_participants
    shared_participants = SharedAttachment.new(activity_params)
    if shared_participants.save
      redirect_to participant_attachments_path
    end
  end

  private

  def activity_params
    params.require(:participant_attachments).permit(
      :participant_id, :attachment, shared_attachments_attributes: [:participant_attachment_id, :participant_id]
    )
  end

  def get_participant_attachments
    @attachments = ParticipantAttachment.attachments(current_participant.id)
  end

  def find_attachment
    @attachment = ParticipantAttachment.find_by_id(params[:id])
  end

  def share_from_params(tag_params)
    tags = case tag_params
      when String
        tag_params.try(:split, ' ')
      when Array
        tag_params
    end
    tags || []
  end
end
