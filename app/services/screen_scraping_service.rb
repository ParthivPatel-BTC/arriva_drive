# This searvice is for fetch images from Amazon, YouTube, iTunes, Google Play and Flipboard sites.
class ScreenScrapingService
  def self.fetch_data_from_web(event_target_url)
    host = URI.parse(event_target_url).host.downcase
    host_name = host.start_with?('www.') ? host[4..-1] : host
    image_data = Nokogiri::HTML(open(event_target_url))
    get_image_from_web(image_data, host_name)
  end

  def self.get_image_from_web(image_data, host_name)
    if host_name.include?('amazon') || host_name.include?('play.google')
      original_image = image_data.search("img").sort_by { |img| img["height"].to_i }[-1]
      image = original_image ? original_image['src'] : 'none'
    else
      image_data.at('/html/head/meta[@property="og:image"]')['content']
    end
  end
end