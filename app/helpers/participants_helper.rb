module ParticipantsHelper
  def get_division_name(division_number)
    case division_number
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
end
