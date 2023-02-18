class MyEventsController < ApplicationController
  def index
    @events = current_user.participated_events

    @organized_events = current_user.organized_events
  end
end
