class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show map]

  def index
    @events = Event.all
    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        info_window: render_to_string(partial: "info_window", locals: {event: event})
      }
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def map
    @events = Event.all
    @spots = Spot.all
    # @run_details = RunDetail.all
    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        info_window: render_to_string(partial: "info_window", locals: {event: event})
      }
    end
    # @markersspots = @spots.geocoded.map do |spot|
    #   {
    #     lat: spot.latitude,
    #     lng: spot.longitude,
    #     info_window: render_to_string(partial: "info_window", locals: {spot: spot})
    #   }
    # end
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
end
