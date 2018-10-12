class Event < ActiveRecord::Base

  WEB_SOURCE_POSSIBLE_VALUES = ['Gorki', 'CO-Berlin']

  validates :title, presence: true
  validates :url, presence: true, uniqueness: true
  validates :start_date, presence: true
  validates :web_source, presence: true, inclusion: {in: WEB_SOURCE_POSSIBLE_VALUES}

  COMPARABLE_FIELDS = [:title, :url, :start_date, :web_source]

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
