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
        'icon3'
      when 2
        'icon2'
      when 3
        'icon5'
      when 4
        'icon4'
      when 5
        'icon6'
    end
  end

  def online_course_activities_tag(participant)
    online_course_activities = Activity.where(activity_type: 5)
    online_course_activities_modified = []
    participant_online_course_ids = participant.participant_online_course_activities.pluck(:activity_id).uniq.compact
    online_course_activities.each do |act|
      if participant_online_course_ids.include?(act.id)
        online_course_activities_modified << [act.title + " - Completed", act.id]
      else
        online_course_activities_modified << [act.title, act.id]
      end
    end
    select_tag("confirm_complete", options_for_select(online_course_activities_modified), prompt: "Select course to mark as complete", style: "width:85%")
  end

  # For deside icon class on activity detail page
  def deside_icon_class(activity_link)
    if host = URI.parse(activity_link).host
      host_name = host.downcase.start_with?('www.') ? host[4..-1] : host
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

  def online_course_activities_for_participant(participant,activity)
    (activity.participant_online_course_activities.where participant_id: participant).empty?
  end

  def get_activity_icon_image(activity_type)
    case activity_type
      when 1
        'book_icon@2x.png'
      when 2
        'video_icon@2x.png'
      when 3
        'app_icon@2x.png'
      when 4
        'magazine_icon@2x.png'
      when 5
        'onlinecourse_icon@2x.png'
    end
  end

  def fetch_activity_image_from_scrach(activity)
    ScreenScrapingService.fetch_data_from_web(activity.link) if activity.activity_type != 5
  end
end
