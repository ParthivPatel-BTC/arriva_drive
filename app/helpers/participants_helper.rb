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
end
