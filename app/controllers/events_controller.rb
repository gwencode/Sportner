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
end
