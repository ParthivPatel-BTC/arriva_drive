class Participant::ParticipantAttachmentsController < ApplicationController
  require 'screen_scraping_service'
  layout 'participant'
  before_filter :get_participant_attachments, only: [ :index, :destroy ]
  before_filter :find_attachment, only: [ :destroy, :shred_participants_list, :create_shared_participants ]
  # before_filter :find_shared_ids, only: [ :create_shared_participants ]
  # before_filter :find_shared_ids, only: [ :shared_participants_list, :tag_participants_files, :create_shared_participants ]
  before_filter :find_shared_ids, only: [ :shared_participants_list, :tag_participants_files ]
  skip_before_filter :verify_authenticity_token, only: [ :callback ]

  def new
    @attachment = ParticipantAttachment.new
  end

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

  # def shred_participants_list
  #   @participants = Network.all_participants_in_network(current_participant)
  #   @shared_participants = SharedAttachment.shared_attachment_participants(@attachment.id)
  # end
  
  # remove this-- if not used 
  def shared_participants_list
    @participants = Network.all_participants_in_network(current_participant)
  end

  def create_shared_participants
    if @attachment.update_attributes(activity_params)
      send_notification(@participant_ids)
      redirect_to participant_attachments_path
    else
      redirect_to participant_attachments_path
    end
  end

  def tag_participants_files
    render :new
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

  def tag_map(tag_ids, type)
    return [] unless tag_ids
    tag_ids.inject([]) { |arr, id| arr << { taggable_id: id, taggable_type: type } } || []
  end

  def prepare_tags_map
    tag_map(@tagged_participants, 'Participant')
  end

  def activity_params
    # params.require(:participant_attachments).permit(:content,
    #   :participant_id, :attachment, :participant_attachment_id, participant_ids: []
    # )
    params.require(:participant_attachments).permit(:content,
      :participant_id, :attachment, :participant_attachment_id, participant_ids: []
    ).merge!({
      tags_attributes: prepare_tags_map
    })
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
    # existing_participant_ids = @attachment.participant_ids
    # selected_participant_ids = params[:participant_attachments][:participant_ids].collect {|v| v.to_i if v.to_i > 0}.compact
    # @participant_ids = selected_participant_ids - existing_participant_ids

    @tagged_participants = share_from_params(params[:participant_ids])
    @attachment = ParticipantAttachment.new(activity_params)
  end

  def send_notification(participant_ids)
    participant_ids.each do |participant_id|
      ParticipantAttachment.send_shared_notification(@attachment, participant_id.to_i, current_participant.email)
    end
  end
end
