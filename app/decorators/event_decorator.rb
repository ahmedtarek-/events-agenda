# app/decorators/event_decorator.rb
class EventDecorator < Draper::Decorator
  def start_date
    object.start_date.strftime('%-b %-e %-Y')
  end

  def end_date
    object.end_date.strftime('%-b %-e %-Y')
  end

  def date_range
    return start_date if object.start_date == object.end_date
    "#{start_date} - #{end_date}"
  end
end
