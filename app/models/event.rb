class Event < ActiveRecord::Base

  WEB_SOURCE_POSSIBLE_VALUES = ['Gorki', 'CO-Berlin']

  validates :title, presence: true
  validates :url, presence: true, uniqueness: true
  validates :start_date, presence: true
  validates :web_source, presence: true, inclusion: {in: WEB_SOURCE_POSSIBLE_VALUES}

  COMPARABLE_FIELDS = [:title, :url, :start_date, :web_source]

  scope :with_ordered_by_date, -> { order(start_date: :asc) }
  scope :with_happening_now_or_later, -> {
    where('start_date > ? OR (start_date < ? AND end_date > ?)',
      Time.zone.today, Time.zone.today, Time.zone.today)
  }

  scope :filter_title, ->(title) { where('lower(title) LIKE lower(?)', title) }
  scope :filter_date, ->(date) { where('start_date <= ? AND end_date >= ? ', date, date) }
  scope :filter_web_source, ->(web_source) { where(web_source: web_source) }
  
  def equals?(json_object)
    COMPARABLE_FIELDS.map { |field| send(field) == json_object[field] }.all?
  end

  class << self
    # Returns false if given object is not complete
    # Cleans json_object of other unimportant fields
    def equivalent_record_exists?(json_object)
      return false unless (COMPARABLE_FIELDS - json_object.keys).empty?

      Event.exists?(json_object.select { |key, _| COMPARABLE_FIELDS.include?(key) })
    end
  end
end
