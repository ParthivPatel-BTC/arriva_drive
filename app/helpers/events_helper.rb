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

  def participant_event_time_formatted(event_date)
    event_date.strftime('%I.%M')
  end
end
