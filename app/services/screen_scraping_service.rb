# This searvice is for fetch images from Amazon, YouTube, iTunes, Google Play and Flipboard sites.
class ScreenScrapingService
  def self.fetch_data_from_web(event_target_url)
    if host = URI.parse(event_target_url).host
      host = host.downcase
      host_name = host.start_with?('www.') ? host[4..-1] : host
      begin
        image_data = Nokogiri::HTML(open(event_target_url))
        get_image_from_web(image_data, host_name)
      rescue
      end
    end
  end

  def self.get_image_from_web(image_data, host_name)
    if host_name.include?('amazon')
      img_select_one = image_data.css("#prodImageContainer #prodImageCell img")
      img_select_two = image_data.css("#holderMainImage img")
      img_select_three = image_data.css("#img-wrapper #img-canvas img")
      if img_select_one.present?
        image_link = img_select_one
      elsif img_select_two.present?
        image_link = img_select_two
      else
        image_link = img_select_three
      end
      image_src = image_link.attribute('src')
    elsif host_name.include?('play.google')
      image_link = image_data.css(".cover-container img")
      image_src = image_link.attribute('src')
    else
      image_data.at('/html/head/meta[@property="og:image"]')['content'] if image_data.at('/html/head/meta[@property="og:image"]')
    end
  end

  def self.find_email_input_hidden_value(email_content)
    email_body_content = Nokogiri::HTML(email_content)
    notification_type = email_body_content.css("input[name=notification_type]").attr("value").to_s
    owner_id = email_body_content.css("input[name=owner_id]").attr("value").to_s
    [ notification_type, owner_id ]
  end
end