# app/services/web_crawler.rb

class WebCrawler
  def data_scraper(url)
    Nokogiri::HTML(open(url))
  end
end


class GorkiWebCrawler < WebCrawler

end
