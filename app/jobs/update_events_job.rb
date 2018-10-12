class UpdateEventsJob < ApplicationJob
  queue_as :default

  class HitExistingRecordError < StandardError
  end

  def perform(*args)
    gorki_crawler = GorkiWebCrawler.new

    puts 'Started crawling Gorki data...'
    trigger_crawler(gorki_crawler)
  end

  def trigger_crawler(crawler)
    page = 1
    hit_existing_record = false

    until hit_existing_record
      response = crawler.crawl(page)
      if response[:status] == 'fail' || response[:count].zero?
        puts 'Stopping. End of crawled data'
        return
      end

      events = response[:data]

      begin
        try_creating_events(events)
      rescue HitExistingRecordError => e
        puts "Stopping. #{e}"
        return
      end

      page += 1
    end
  end

  def try_creating_events(events)
    count = 0
    events.each do |event|
      raise HitExistingRecordError.new(message: "No more new records. Successfully created #{count}") if Event.equivalent_record_exists?(event)

      record = Event.new(event_params(event))
      count += 1 if record.save
    end

    puts "Successfully created #{count} Event records"
  end

  def event_params(event_object)
    event_object.select { |key, _| Event.attribute_names.map(&:to_sym).include?(key) }
  end
end
