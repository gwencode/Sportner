class SpotsController < ApplicationController
  def index
    @spots = Spot.all
  end

  def show
    @spot = Spot.find(params[:id])
    set_weather_data
  end

  def map
    @spots = Spot.all
    @markers = @spots.geocoded.map do |spot|
      {
        lat: spot.latitude,
        lng: spot.longitude,
        info_window: render_to_string(partial: "spot_info_window", locals: {spot: spot}),
        image_url: helpers.asset_url("vague.svg")
      }
    end
  end

  private

  def set_weather_data
    @weather_data = @spot.call_weather_api
    if Time.now.hour >= 0 && Time.now.hour <= 9
      @hourly_data = @weather_data[:data][:weather][0][:hourly].select { |i| i[:time] == "600" }.first
    elsif Time.now.hour >= 10 && Time.now.hour <= 15
      @hourly_data = @weather_data[:data][:weather][0][:hourly].select { |i| i[:time] == "1200" }.first
    else
      @hourly_data = @weather_data[:data][:weather][0][:hourly].select { |i| i[:time] == "1800" }.first
    end
    @temp_c = @hourly_data[:tempC]
    @watertemp_c = @hourly_data[:waterTemp_C]
    @windspeedkmph = @hourly_data[:windspeedKmph]
    @winddirdegree = @hourly_data[:winddirDegree]
    @winddir16point = @hourly_data[:winddir16Point]
    @swellheight_m = @hourly_data[:swellHeight_m]
    @swellperiod_secs = @hourly_data[:swellPeriod_secs]
    @swelldir16point = @hourly_data[:swellDir16Point]

    # @tidelow1 = @weather_data[:data][:weather][0][:tides][0][:tide_data][0][:tideDateTime]
    @tide = [
      [@weather_data[:data][:weather][0][:tides][0][:tide_data][0][:tideDateTime], @weather_data[:data][:weather][0][:tides][0][:tide_data][0][:tide_type]],
      [@weather_data[:data][:weather][0][:tides][0][:tide_data][1][:tideDateTime], @weather_data[:data][:weather][0][:tides][0][:tide_data][1][:tide_type]],
      [@weather_data[:data][:weather][0][:tides][0][:tide_data][2][:tideDateTime], @weather_data[:data][:weather][0][:tides][0][:tide_data][2][:tide_type]],
      [@weather_data[:data][:weather][0][:tides][0][:tide_data][3][:tideDateTime], @weather_data[:data][:weather][0][:tides][0][:tide_data][3][:tide_type]]
  ]
  end
end
