class Participant::NotesController < ApplicationController
  layout 'participant'
  before_filter :participant_user_required!
  before_filter :find_set_note, only: [:destroy]

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

  private

  def note_params
    params.require(:note).permit(:content)
  end

  def find_set_note
    @note = Note.find_by_id(params[:id])
  end
end
