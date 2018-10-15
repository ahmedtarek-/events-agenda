class EventsController < ApplicationController
  
  before_action :set_events, only: [:index]
  before_action :set_event, only: [:show]

  def index

  end

  def show
  end

  private

  def set_events
    @events = EventFilter.new(index_params).execute
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def index_params
    date = ApplicationHelper.date_params_to_date_object(params)
    params.merge(date: date).permit(EventsHelper.index_params)
  end
end