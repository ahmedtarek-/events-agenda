# app/services/event_filter.rb
class EventFilter
  FILTER_FIELDS = %w[title date web_source].freeze

  def initialize(params = {})
    @filter_fields = params.select { |field, value| FILTER_FIELDS.include?(field) && value.present? }
  end

  def execute
    events = Event.with_ordered_by_date
    @filter_fields.each do |field, value|
      events = events.send("filter_#{field}", value)
    end
    events
  end
end
