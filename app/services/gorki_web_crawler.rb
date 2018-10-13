# app/services/gorki_web_crawler.rb
class GorkiWebCrawler < WebCrawler
  BASE_URL = 'https://gorki.de'
  URL = 'https://gorki.de/en/programme'
  NAME = 'Gorki'

  def crawl(page_number)
    @current_page = page_number

    begin
      scrapped_page = data_scraper(page_url)
      crawl_page(scrapped_page, page_date)
    rescue OpenURI::HTTPError, Errno::ENOENT
      respond_with_failure('Could not open page')
    end
  end

  class << self
    def page_to_date_mapping
      @page_to_date_mapping ||= [*0..2].map do |next_value|
        day = Date.today.next_month(next_value)
        [next_value, "#{day.year}/#{day.month}"]
      end.to_h
    end
  end

  private

  def crawl_page(page, base_date)
    events = []

    sections = page.css('div.item-list.schedule-item-list.sticky-wrap')

    sections.each do |section|
      date = Date.parse("#{base_date}/#{section.css('h2.schedule-item-list--date--day').first.text}")
      rows = section.css('div.item-list--item')

      rows.each do |row|
        events << parse_row(row, date)
      end
    end

    respond_with_success(events)
  end

  def parse_row(row, date)
    main_info   = row.css('h3.is-headline-sub.is-secondary').first&.text || ''
    second_info = row.css('div.schedule-changes--content.normal-note > p').first.text || ''
    category    = second_info.split.first

    event_info = "#{main_info.split.join(' ')}\n#{second_info.split.slice(1..second_info.size).join(' ')}"
    description = row.css('div.cast > ul > li').map { |item| item.text.split.join(' ') }.join(', ')

    img = !row.css('picture > img').first.nil? ? BASE_URL + row.css('picture > img').first['src'] : ''

    {
      title:      row.css('h2 > a').first.text,
      category:   category,
      desc:       description,
      event_info: event_info,
      img_url:    img,
      url:        row.css('h2 > a').first.attributes['href'].value,
      start_date: date.to_s,
      end_date:   date.to_s,
      web_source: NAME
    }
  end

  def page_date
    GorkiWebCrawler.page_to_date_mapping[@current_page]
  end

  def page_url
    "#{URL}/#{page_date}/all"
  end
end
