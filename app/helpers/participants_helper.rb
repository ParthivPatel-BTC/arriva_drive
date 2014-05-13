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
end
