class WeatherController < ApplicationController

  def create

  end

  def forecast
    @forecasts = WeatherService.new(params[:city]).get_forecast
    render json: @forecasts
  end
end
