class Participant::NotesController < ApplicationController
  layout 'participant'
  before_filter :participant_user_required!
  before_filter :find_set_note, only: [:index, :destroy]
  before_filter :set_tagged_behaviours_n_participants, only: [
    :tag_participants_list, :tag_behaviours_list, :tag_participants_behaviours, :create
  ]

  def index
    tagged_notes = get_tagged_notes
    @notes = ( current_participant.notes.order('created_at DESC') + tagged_notes ).uniq
    @points_earned = (@note.tags.behaviour_tags.count * Settings.activity_points.write_note) if @note.present?
  end

  def new
    @note = Note.new
  end

  def create
    @note = current_participant.notes.create(note_params)
    if @note.persisted?
      flash[:notice] = t('participant.msg.success.note_creation')
      redirect_to participant_notes_path(id: @note.id)
    else
      render :new
    end
  end

  def destroy
    @note.destroy
    flash[:notice] = t('participant.msg.success.note_destroy')
    redirect_to participant_notes_path
  end

  def tag_participants_list
    @participants = Network.all_participants_in_network(current_participant)
  end

  def tag_participants_behaviours
    render :new
  end

  def tag_behaviours_list
    @behaviours = Behaviour.all
  end

  private

  def get_tagged_notes
    note_ids = Tag.by_participant(current_participant).pluck(:note_id)
    Note.where(id: note_ids).order('created_at DESC')
  end

  def tag_map(tag_ids, type)
    return [] unless tag_ids
    tag_ids.inject([]) { |arr, id| arr << { taggable_id: id, taggable_type: type } } || []
  end

  def prepare_tags_map
    tag_map(@tagged_behaviours, 'Behaviour') + tag_map(@tagged_participants, 'Participant')
  end

  def note_params
    params.require(:note).permit(:content).merge!({ 
      tags_attributes: prepare_tags_map
    })
  end

  def find_set_note
    @note = Note.find_by_id(params[:id])
  end

  def set_tagged_behaviours_n_participants
    @tagged_behaviours = extract_tags_from_params(params[:behaviour_ids])
    @tagged_participants = extract_tags_from_params(params[:participant_ids])
    @note = Note.new(note_params)
  end

  def extract_tags_from_params(tag_params)
    tags = case tag_params
      when String
        tag_params.try(:split, ' ')
      when Array
        tag_params
    end
    tags || []
  end
end
