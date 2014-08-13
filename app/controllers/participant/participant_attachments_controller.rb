class Participant::ParticipantAttachmentsController < ApplicationController
  require 'screen_scraping_service'
  layout 'participant'
  before_filter :get_participant_attachments, only: [ :index, :destroy ]
  before_filter :find_attachment, only: [ :destroy, :shred_participants_list, :create_shared_participants ]
  before_filter :find_shared_ids, only: [ :create_shared_participants ]
  skip_before_filter :verify_authenticity_token, only: [ :callback ]

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
    if @attachment.update_attributes(activity_params)
      send_notification(@participant_ids)
      redirect_to participant_attachments_path
    else
      redirect_to participant_attachments_path
    end
  end

  def callback
    replay_email_content = ScreenScrapingService.find_email_input_hidden_value(params[:html])
    if replay_email_content == 'notes'
      params[:participant_attachments] = {}
      params[:participant_attachments][:content] = params[:reply_plain]
      note = Note.new(activity_params)
      note.save
    end
  end

  private

  def activity_params
    params.require(:participant_attachments).permit(:content,
      :participant_id, :attachment, :participant_attachment_id, participant_ids: []
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

  def find_shared_ids
    existing_participant_ids = @attachment.participant_ids
    selected_participant_ids = params[:participant_attachments][:participant_ids].collect {|v| v.to_i if v.to_i > 0}.compact
    @participant_ids = selected_participant_ids - existing_participant_ids
  end

  def send_notification(participant_ids)
    participant_ids.each do |participant_id|
      ParticipantAttachment.send_shared_notification(@attachment, participant_id.to_i)
    end
  end
end
