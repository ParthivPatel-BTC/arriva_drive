class Participant::NotesController < ApplicationController
  layout 'participant'
  before_filter :participant_user_required!
  before_filter :find_set_note, only: [:destroy]
  before_filter :set_tagged_behaviours_n_participants, only: [
    :tag_participants, :tag_behaviours, :tag_participants_behaviours, :create
  ]

  def index
    @notes = current_participant.notes.order('created_at DESC')
  end

  def new
    @note = Note.new
  end

  def create
    @note = current_participant.notes.create(note_params)
    if @note.persisted?
      flash[:notice] = t('participant.msg.success.note_creation')
      redirect_to participant_notes_path
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
    @participants = Network.participants_in_network(current_participant)
  end

  def tag_participants_behaviours
    render :new
  end

  def tag_behaviours_list
    @behaviours = Behaviour.all
  end

  private

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
    @tagged_behaviours = params[:behaviour_ids].try(:split, ',')
    @tagged_participants = params[:participant_ids].try(:split, ',')
    @note = Note.new(note_params)
  end
end
