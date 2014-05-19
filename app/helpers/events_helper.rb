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
end
