# app/services/web_crawler.rb
require 'open-uri'

class WebCrawler

  SUCCESS_STATUS = 'success'
  FAILURE_STATUS = 'fail'

  def initialize(current_page = 1)
    @current_page = current_page
  end

  private

  attr_accessor :current_page

  def crawl_page(url)
    data_scraper(url)
  end

  def respond_with_success(events)
    {
      data: events,
      count: events.size,
      status: SUCCESS_STATUS
    }
  end

  def respond_with_failure(msg)
    {
      message: msg,
      status: FAILURE_STATUS
    }
  end

  def next_page
    @current_page + 1
  end

  def data_scraper(url)
    return if url.nil?
    Nokogiri::HTML(open(url))
  end
end
