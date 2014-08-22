class Participant::ParticipantAttachmentsController < ApplicationController
  require 'screen_scraping_service'
  layout 'participant'
  before_filter :get_participant_attachments, only: [ :index, :destroy ]
  before_filter :find_attachment, only: [ :index, :destroy, :shared_participants_list, :create_shared_participants ]
  skip_before_filter :verify_authenticity_token, only: [ :callback ]

  def new
    @participants = shared_participants_list
    @attachment = ParticipantAttachment.new
  end

  def index
  end  

  def create      
    @attachment = ParticipantAttachment.new(activity_params)
    @attachment.participant = current_participant
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

   def create_shared_participants
    if @attachment.update_attributes(activity_params)
      # send_notification(@participant_ids)
      redirect_to participant_attachments_path
    else
      redirect_to participant_attachments_path
    end
  end

  def shared_participants_list
    @tagged_participants = SharedAttachment.shared_attachment_participants(params[:id]).pluck(:participant_id)
    @participants = Network.all_participants_in_network(current_participant)
  end

  def shared_participants 
    @participants = shared_participants_list
    respond_to do |format|
      format.html { render 'participant/participant_attachments/shared_participants_list' }
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
    params.require(:participant_attachments).permit(:file_title, :content, :participant_id, :attachment, :participant_attachment_id, participant_ids: []
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

  def send_notification(participant_ids)
    participant_ids.each do |participant_id|
      ParticipantAttachment.send_shared_notification(@attachment, participant_id.to_i, current_participant.email)
    end
  end
end