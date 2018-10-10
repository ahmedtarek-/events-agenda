# app/services/gorki_web_crawler.rb
class GorkiWebCrawler < WebCrawler
  URL = 'https://gorki.de/en/programme'
  NAME = 'Gorki'

  def crawl
    url = page_to_url(@current_page)
    base_date = page_to_date(@current_page)
    crawl_page(url, base_date)
  end

  private

  def crawl_page(url, base_date)
    events = []
    page = data_scraper(url)

    sections = page.css('div.item-list.schedule-item-list.sticky-wrap')

    sections.each do |section|
      date = Date.parse("#{base_date}/#{section.css('h2.schedule-item-list--date--day').first.text}")
      rows = section.css('div.item-list--item')

      rows.each do |row|
        events << parse_row(row, date)
      end
    end

    events
  end

  def parse_row(row, date)
    main_info   = row.css('h3.is-headline-sub.is-secondary').first&.text || ''
    second_info = row.css('div.schedule-changes--content.normal-note > p').first.text || ''
    category    = second_info.split.first

    event_info = "#{main_info.split.join(' ')}\n#{second_info.split.slice(1..second_info.size).join(' ')}"
    description = row.css('div.cast > ul > li').map { |item| item.text.split.join(' ') }.join(', ')

    img = !row.css('picture > img').first.nil? ? URL + row.css('picture > img').first['src'] : ''

    {
      title:      row.css('h2 > a').first.text,
      category:   category,
      desc:       description,
      event_info: event_info,
      img:        img,
      url:        row.css('h2 > a').first.attributes['href'].value,
      start_date: date,
      end_date:   date,
      source:     NAME
    }
  end

  def page_to_date(page)
    page_to_date_mapping[page]
  end

  def page_to_url(page)
    date = page_to_date(page)
    "#{URL}/#{date}/all"
  end

  def page
    current_page
  end

  def page_to_date_mapping
    @mapping ||= [*0..2].map do |next_value|
      day = Date.today.next_month(next_value)
      [next_value, "#{day.year}/#{day.month}"]
    end.to_h
  end
end
