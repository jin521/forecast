class WeatherController < ApplicationController

  def forecast
    @forecasts = WeatherService.new(params[:city]).get_forecast
    render json: @forecasts
  end
end
