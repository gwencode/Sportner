class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show map]

  def index
    @event = Event.new

    if params[:meeting_point].present?
      events = Event.where("meeting_point ILIKE ?", "%#{params[:meeting_point]}%")
    else
      events = Event.all
    end

    if params[:query].present?
      level_events = events.where(difficulty: params[:query])
      @events = level_events.where("date > ?", DateTime.now)
    else
      @events = events.where("date > ?", DateTime.now)
    end

    if current_user
      @organized_events = current_user.organized_events
    else
      @organized_events = nil
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
    set_weather_event_data if ((@event.date - Time.now) / (60 * 60 * 24)).round < 15
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
    @event = Event.new.tap(&:build_run_detail)
  end

  def create
    @event = Event.new(event_params)
    @event.organizer = current_user
    if @event.save!
      participation = Participation.new(event: @event, user: current_user)
      participation.save
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
                                  :name,
                                  :date,
                                  :description,
                                  :max_people,
                                  :meeting_point,
                                  :car_pooling,
                                  :passengers,
                                  :spot_id,
                                  :run_detail_id,
                                  :difficulty,
                                  photos: [],
                                  run_detail_attributes: %i[run_type
                                                            distance
                                                            pace
                                                            duration
                                                            elevation
                                                            location])
  end

  def set_weather_event_data
    @weather_data = @event.call_weather_event_api

    if Time.now.hour >= 0 && Time.now.hour <= 9
      @hourly_data = @weather_data[:data][:weather][0][:hourly].select { |i| i[:time] == "600" }.first
    elsif Time.now.hour >= 10 && Time.now.hour <= 15
      @hourly_data = @weather_data[:data][:weather][0][:hourly].select { |i| i[:time] == "1200" }.first
    else
      @hourly_data = @weather_data[:data][:weather][0][:hourly].select { |i| i[:time] == "1800" }.first
    end
    @temp_c = @hourly_data[:tempC]
    @windspeedkmph = @hourly_data[:windspeedKmph]
    @winddirdegree = @hourly_data[:winddirDegree]
    @winddir16point = @hourly_data[:winddir16Point]
    @swellperiod_secs = @hourly_data[:swellPeriod_secs]
    @weathericonurl = @hourly_data[:weatherIconUrl][0][:value]
    @lang_fr = @hourly_data[:lang_fr][0][:value]
  end
end
