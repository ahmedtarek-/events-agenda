# app/services/co_web_crawler.rb
class COWebCrawler < WebCrawler
  URL = 'https://www.co-berlin.org/en/calender'
  NAME = 'CO-Berlin'

  def crawl(page_number)
    @current_page = page_number

    begin
      scrapped_page = data_scraper(page_url)
      crawl_page(scrapped_page)
    rescue OpenURI::HTTPError, Errno::ENOENT
      respond_with_failure('Could not open page')
    end
  end

  private

  def crawl_page(page)
    events = []

    rows = page.css('div.seite-c-single')

    rows.each do |row|
      events << parse_row(row)
    end

    respond_with_success(events)
  end

  def parse_row(row)
    start_date_present = !row.css('span.date-display-start').first.nil?

    if start_date_present
      start_date = row.css('span.date-display-start').first['content']
      end_date   = row.css('span.date-display-end').first['content']
    else
      start_date = row.css('span.date-display-single').first
      end_date   = start_date
    end

    {
      title:      row.css('div.article-title').text,
      category:   row.css('span.article-category').text,
      desc:       row.css('div.article-subtitle').text,
      event_info: row.css('div.article-text').text,
      img:        row.css('div.calender-image > img').first['src'],
      start_date: DateTime.parse(start_date).to_s,
      end_date:   DateTime.parse(end_date).to_s,
      url:        row.css('a').first.attributes['href'].value,
      web_source: NAME
    }
  end

  # CO-Berlin website returns empty results if content fills
  # only one page and the url requests page=1
  def page_url
    page_value = @current_page == 1 ? 0 : @current_page
    "#{URL}?page=#{page_value}"
  end
end
