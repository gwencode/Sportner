class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show map]

  def index
    @event = Event.new
    if params[:query].present?
      @events = Event.where(difficulty: params[:query])
    else
      @events = Event.all
    end
    if current_user
      @organized_events = current_user.organized_events
    else
      @organized_events = nil
    end
    if params[:meeting_point].present?
      @events = Event.where("meeting_point ILIKE ?", "%#{params[:meeting_point]}%")
    else
      @events = Event.all
    end
    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        info_window: render_to_string(partial: "info_window", locals: {event: event}),
        image_url: helpers.asset_url("event-flag.png")
      }
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def map
    @events = Event.all
    @spots = Spot.all
    @run_details = RunDetail.all

    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        info_window: render_to_string(partial: "info_window", locals: {event: event}),
        image_url: helpers.asset_url("event-flag.png")
      }
    end

    @spotmarkers = @spots.geocoded.map do |spot|
      {
        lat: spot.latitude,
        lng: spot.longitude,
        info_window: render_to_string(partial: "spot_info_window", locals: {spot: spot}),
        image_url: helpers.asset_url("vague.png")
      }
    end

    @runmarkers = @run_details.geocoded.map do |run|
      {
        lat: run.latitude,
        lng: run.longitude,
        info_window: render_to_string(partial: "run_info_window", locals: {run: run}),
        image_url: helpers.asset_url("run-flag.png")
      }
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.organizer = current_user
    if @event.save!
      redirect_to event_path(@event), success: "Evenement créé 👍"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def event_params
    params.require(:event).permit(:event_type,
                                  :name, :date,
                                  :description,
                                  :max_people,
                                  :meeting_point,
                                  :car_pooling,
                                  :passengers,
                                  :difficulty)
  end
end
