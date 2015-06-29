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

  def cohort_submit_btn_caption(cohort)
    cohort.new_record? ? t('cohort.btn.save') : t('cohort.btn.edit')
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

  def event_time_interval(event_start_time, event_end_time)
    "#{event_start_time.strftime('%l%P')} - #{event_end_time.strftime('%l%P')}"
  end

  def month_name_with_year(month)
    "#{Date::MONTHNAMES[month]} #{Date.today.year}"
  end

  def set_month_scroller_active(first_month, second_month, year)
    current_month = Date::MONTHNAMES[Date.today.month].to_s
    (first_month == current_month || second_month == current_month) && year == Date.today.year.to_s ? 'ui-tabs-active ui-state-active' : ''
  end
end