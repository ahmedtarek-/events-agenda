class EventFilter
  FILTER_FIELDS = %w[title date web_source]
  
  def initialize(params = {})
    @filter_fields = params.select { |field, value| FILTER_FIELDS.include?(field) && value.present? }
    # binding.pry
  end

  def execute
    events = Event.with_ordered_by_date
    @filter_fields.each do |field, value|
      events = events.send("filter_#{field}", value)
    end
    events
  end
end
