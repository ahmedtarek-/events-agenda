class Event < ActiveRecord::Base

  WEB_SOURCE_POSSIBLE_VALUES = ['Gorki', 'CO']

  validates :title, presence: true
  validates :url, presence: true, uniqueness: true
  validates :start_date, presence: true
  validates :web_source, presence: true, inclusion: {in: WEB_SOURCE_POSSIBLE_VALUES}

  COMPARABLE_FIELDS = [:title, :url, :start_date]

  def equals?(json_object)
    COMPARABLE_FIELDS.map { |field| send(field) == json_object[field] }.all?
  end
end