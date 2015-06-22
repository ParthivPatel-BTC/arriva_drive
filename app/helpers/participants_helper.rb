module ParticipantsHelper
  def get_division_name(division_number)
    case division_number
    when 1
      'Uk Bus'
    when 2
      'Uk Trains'
    when 3
      'Mainland Europe'
    when 4
      'Group'
    end
  end

  def get_score_value(behaviour, participant)
    behaviour_id = behaviour.id
    participant_id = participant.id
    scores = Score.behaviour_scores.where('participant_id = ? and scorable_id = ?', participant_id, behaviour_id)
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

  # Set margin-top for alpha search right bar in My Network page
  def set_margin_for_alpha_character(total_participants)
    return nil if total_participants < 5
    ((total_participants - 3) * 4) - 1
  end

  def participant_online_course_completed(current_participant, activity)
    current_participant.participant_online_course_activities.where(activity_id: activity.id, completed: true).empty?
  end

  # Deside level for participants in My Network page
  def deside_level(participant)
    find_level(participant.scores.sum(:score))
  end

  def find_level(score)
    if (0..110).include?(score)
      1
    elsif (111..1999).include?(score)
      2
    elsif (2000..2999).include?(score)
      3
    elsif (3000..3999).include?(score)
      4
    elsif (4000..5000).include?(score)
      5
    else
      0
    end
  end

  def activity_summary(completed_activities, total_activities)
    return 0 if total_activities == 0
    (completed_activities * 100) / total_activities
  end

  def count_shared_attachments(attachments)
    count = 0
    attachments.each do |attachment|
      if attachment.participants.present?
        count = count + 1
      end
    end
    count
  end
end
