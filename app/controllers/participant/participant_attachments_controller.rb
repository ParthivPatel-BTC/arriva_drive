class Participant::ParticipantAttachmentsController < ApplicationController
  require 'screen_scraping_service'
  layout 'participant'
  require 'mail'
  before_filter :shared_unshared_attachments, only: [ :index, :destroy ]
  before_filter :find_attachment, only: [ :index, :destroy, :shared_participants_list, :create_shared_participants, :show_attachment ]
  before_filter :shared_participants_list, only: [:create]
  before_filter :find_shared_ids, only: [ :create_shared_participants ]
  skip_before_filter :verify_authenticity_token, only: [ :callback ]
  before_filter :find_attachment_by_participant_attachments_id, only: [ :create ]
  
  def index
    @tagged_participants = SharedAttachment.shared_attachment_participants(params[:id]).pluck(:participant_id)
    @current_participant_networks = Network.all_participants_in_network(current_participant)
    @shared_list = shared_participants_list
    @attachment = ParticipantAttachment.new
  end

  def create
    if @attachment.present?
      if @attachment.update_attributes(participant_attachment_params)
        if params[:participant_attachments][:participant_ids].present?
          send_notification(params[:participant_attachments][:participant_ids])
        else
          @shared_attachments = SharedAttachment.where(participant_attachment_id: @attachment.id)
          @shared_attachments.delete_all
          @attachment.participant = current_participant
          @attachment.save
        end
        redirect_to participant_attachments_path
      else
        render :index
      end
    else
      @attachment = ParticipantAttachment.new(participant_attachment_params)
      @attachment.participant = current_participant
      @attachment.save
      if @attachment.present?
        @attachment.save
        send_notification(params[:participant_attachments][:participant_ids])
        redirect_to participant_attachments_path
      else
        render :index
      end
    end
  end

  def destroy
    if @attachment.participant == current_participant
      @attachment.destroy
    else
      @shared_attachment = SharedAttachment.find_by participant_id: current_participant.id
      SharedAttachment.destroy(@shared_attachment)
    end
      redirect_to participant_attachments_path
  end

  def create_shared_participants
    if @attachment.update_attributes(participant_attachment_params)
      send_notification(@participant_ids)
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
    return if params[:content].empty?
    mail = Mail.new(params[:content])

    reply = EmailReplyParser.read(mail.body.raw_source)
    content = ""
    text = "WRITE BELOW THIS LINE\n>"
    is_next = false
    reply.fragments.each do |fragment|
      if is_next
        content = fragment.content
        break
      end
      if fragment.content[fragment.content.size-text.size, fragment.content.size].eql?(text)
        is_next = true
      end
    end

    id_values = mail.to.to_s.gsub(/[^0-9_]/, '').split('_')
    owner_id = id_values[0].to_i
    shared_participant_id = id_values[1].to_i

    params[:participant_attachments] = {}
    params[:participant_attachments][:content] = content
    params[:participant_attachments][:owner_id] = owner_id
    note = Note.new(participant_attachment_params)
    if note.save
      puts "NOTE CREATED SUCCESSFULLY WITH ID = #{note.id}"
      tag = Tag.new
      tag.note = note
      tag.taggable = Participant.find_by_id(shared_participant_id)
      if !tag.save
        puts "#{tag.errors.full_messages}"
      end
    else
      puts "Note could not be created."
      puts "#{note.errors.full_messages}"
    end
  end

  def show_attachment
    send_file @attachment.attachment.path, :type => @attachment.attachment.content_type, :disposition => 'inline'
  end

  private

  def participant_attachment_params
    params.require(:participant_attachments).permit(:id, :file_title, :content, :participant_id, :attachment, :participant_attachment_id, :owner_id, :file_description, participant_ids: []
    )
  end

  def get_participant_attachments
    @attachments = ParticipantAttachment.attachments(current_participant.id)
  end

  def find_attachment
    @attachment = ParticipantAttachment.find_by_id(params[:id])
  end

  def find_attachment_by_participant_attachments_id
    if params[:participant_attachments][:id].present?
      @attachment = ParticipantAttachment.find(params[:participant_attachments][:id])
    end
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
    return false if participant_ids.nil?
    participant_ids.each do |participant_id|
    ParticipantAttachment.send_shared_notification(@attachment, participant_id.to_i, current_participant) if Participant.find_by_id(participant_id).files_notification
    end
  end

  def find_shared_ids
    existing_participant_ids = @attachment.participant_ids
    selected_participant_ids = params[:participant_attachments][:participant_ids].collect {|v| v.to_i if v.to_i > 0}.compact
    @participant_ids = selected_participant_ids - existing_participant_ids
  end

  def shared_unshared_attachments
    @attachments = current_participant.participant_attachments + current_participant.shared_attachments.map(&:participant_attachment)
    @shared_attachments = current_participant.shared_attachments
    @tagged_participants = SharedAttachment.shared_attachment_participants(current_participant.id).pluck(:participant_id)
  end
end