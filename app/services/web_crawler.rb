# app/services/web_crawler.rb
require 'open-uri'

class WebCrawler
  def initialize(current_page = 1)
    @current_page = current_page
  end

  def data_scraper(url)
    Nokogiri::HTML(open(url))
  end

  private

  attr_accessor :current_page
end
