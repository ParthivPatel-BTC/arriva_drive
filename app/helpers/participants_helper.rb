module ParticipantsHelper
  def check_and_set_division(division)
    case division
    when 1
      'Uk Bus'
    when 2
      'Uk Trains'
    when 3
      'Mainland Europe'
    end
  end

  def get_score_value(behaviour, participant)
    behaviour_id = behaviour.id
    participant_id = participant.id
    scores = Score.where('participant_id = ? and behaviour_id = ? ', participant_id, behaviour_id)
    scores.first
  end

  def performance_summary_length_limit
    Settings.field_length_limit.performance_summary
  end

  def decide_participant_form_url(participant)
     participant.new_record? ? participant : update_participant_path
  end

  def participant_submit_btn_caption(participant)
    participant.new_record? ? t('admin.participant.caption.button.save_participant_only') : t('admin.participant.caption.button.update')
  end
end
