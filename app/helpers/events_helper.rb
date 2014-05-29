module EventsHelper
  def event_description_length_limit
    Settings.field_length_limit.event_description
  end

  def decide_event_form_action(event)
    event.new_record? ? events_path : event_path(event)
  end

  def decide_event_form_method(event)
    event.new_record? ? :post : :put
  end

  def event_listing_class(event)
    event.is_completed? ? 'active' : ''
  end

  def participant_event_date_formatted(event_date)
    event_date.strftime('%d.%m.%Y')
  end

  def participant_event_time_formatted(event_time)
    event_time.strftime('%I.%M')
  end

  # For set margin-bottom for display months on
  # Participants's events scrollbar.
  def margin_for_months_scroller(total_months)
    case total_months
      when 2
        369
      when 3
        175
      when 4
        112
      when 5
        80
      when 7
        47
      when 8
        38
      when 9
        31
      when 10
        26
      when 11
        21
      when 12
        18
      end
  end
end
