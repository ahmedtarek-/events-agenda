class EventsController < ApplicationController
  
  before_action :set_events, only: [:index]
  before_action :set_event, only: [:show]

  def index
  end

  def show
  end

  private

  def set_events
    @events = Event.with_happening_now_or_later.with_ordered_by_date
  end

  def set_event
    @event = Event.find(params[:id])
  end
end