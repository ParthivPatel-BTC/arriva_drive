module ApplicationHelper
  NUMBER_STR_MAP = {1 => 'One', 2 => 'Two', 3 => 'Three', 4 => 'Four'}
  def number_to_string(number)
    NUMBER_STR_MAP[number]
  end

  # For flash messages
  def bootstrap_class_for flash_type
    case flash_type
    when :success
      "alert-success" # Green
    when :error
      "alert-danger" # Red
    when :alert
      "alert-warning" # Yellow
    when :notice
      "alert-info" # Blue
    else
      flash_type.to_s
    end
  end

  def image_present?(obj, image_attr_name)
    return false if obj.blank?
    !obj.try(image_attr_name).blank?
  end

  def image_link_valid?(obj)
    !obj.new_record?
  end

  def find_field_length(str)
    str.try(:size) || 0
  end

  def formatted_date(date, participant_view=false)
    return date.try(:strftime, '%d.%m.%Y') if participant_view
    date.strftime('%d/%m/%Y') rescue nil
  end

  def formatted_time(time)
    time.strftime('%H.%M')
  end

  def formatted_time_with_timezone(time)
    uk_time = time.in_time_zone("London").strftime('%H.%M')
    uk_time += " GMT+1"
  end

  def determine_root_path
    return root_path if current_admin.blank?
    admin_dashboard_path
  end

  # For display admin full name in header after sign in
  def full_name(first_name, last_name)
    "#{first_name} #{last_name}"
  end

  def common_text_field_class
    'form-control'
  end

  def link_to_submit(*args, &block)
    link_to_function (block_given? ? capture(&block) : args[0]), "$(this).closest('form').submit()", args.extract_options!
  end

  def current_participant_notes_count
    current_participant.notes.count rescue nil
  end

  def note_creation_month(note)
    note.created_at.strftime('%B').upcase
  end

  def left_side_bar_class(side_bar_name)
    controller_name == side_bar_name ? 'active' : nil
  end

  def is_activity_index_page?
    controller_name == 'activities' && action_name == 'index'
  end

  # if question of activity has already been answered by current participant?
  # then disable the answers otherwise don't disable
  def answer_disabled_attr(activity)
    'disabled' if current_participant.has_answered_this_activity?(activity)
  end

  # only highlight the correct answer if participant has attempted the question
  def highlighter_class_for_answer(answer, activity)
    return 'correct-answer' if answer.correct && current_participant.has_answered_this_activity?(activity)
  end

  def answer_checked_attr(answer, activity)
    current_participant.activity_answer(activity).try(:id) == answer.id
  end

  def answer_check_box_class(answer, activity)
    'correct-answer-chkbox' if answer_checked_attr(answer, activity)
  end

  # returns the integer number of total completed activities of current participants
  def completed_activities
    current_participant.completed_activities.count
  end

  def formatted_tags(tags)
    tags.inject('') { |str, tag| str << "#{tag.taggable.tag_title}, " }.chop.chop
  end

  def formatted_tags_with_and(tags)
    formatted_tags_string = tags.inject('') { |str, tag| str << "#{tag.taggable.tag_title.titleize}, " }.chop.chop
    if tags.count < 2
      formatted_tags_string
    else
      formatted_tags_string.reverse.sub(' ,', ' dna ').reverse
    end
  end
end
