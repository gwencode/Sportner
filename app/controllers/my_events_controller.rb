class MyEventsController < ApplicationController
  def index
    @events = current_user.participated_events
  end
end
