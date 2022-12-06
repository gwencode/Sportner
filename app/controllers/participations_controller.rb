class ParticipationsController < ApplicationController

  before_action :set_event, only: [:create]
  def create
    participation = Participation.new(event: @event, user: current_user)
    if participation.save!
      redirect_to events_path, notice: "Participation enregistrée"
    else
      redirect_to event_path(@event), notice: "Vous participez déjà à l'event"
    end
  end

  def set_event
    @event = Event.find(params[:event_id])
  end
end
