class Event < ActiveRecord::Base

  validates :title, presence: true
  validates :url, presence: true, uniqueness: true
  validates :start_date, presence: true
  validates :web_source, presence: true

  COMPARABLE_FIELDS = [:title, :url, :start_date]

  def equals?(json_object)
    COMPARABLE_FIELDS.map { |field| send(field) == json_object[field] }.all?
  end
end