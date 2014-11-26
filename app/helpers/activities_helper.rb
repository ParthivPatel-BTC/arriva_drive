module ActivitiesHelper
  def activity_description_length_limit
    Settings.field_length_limit.activity_description
  end

  def decide_activity_form_method(activity)
    activity.new_record? ? :post : :put
  end

  def decide_activity_form_action(activity)
    activity.new_record? ? activities_path : activity_path(activity)
  end

  def get_activity_icon_class(activity_type)
    case activity_type
      when 1
        'bigicon-sustainable'
      when 2
        'bigicon-delivering'
      when 3
        'bigicon-brain'
      when 4
        'bigicon-putting'
      when 5
        'bigicon-putting'
    end
  end

  # For deside icon class on activity detail page
  def deside_icon_class(activity_link)
    host = URI.parse(activity_link).host.downcase
    host_name = host.start_with?('www.') ? host[4..-1] : host
    if host_name.include? ('amazon')
      'icon-amazon'
    elsif host_name.include? ('youtube')
      'icon-watchvideo'
    elsif host_name.include?('apple') || host_name.include?('play.google')
      'icon-watchvideo'
    elsif host_name.include? ('flipboard')
      'icon-sustainable'
    else
    end
  end
end
