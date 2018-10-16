class EventsController < ApplicationController
  
  before_action :set_events, only: [:index]
  before_action :set_event, only: [:show]

  def index
    @values = index_params.to_h
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
    params[:date] = ApplicationHelper.date_params_to_date_object(params)
    params.permit(EventsHelper.index_params)
  end
end