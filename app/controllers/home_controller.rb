class HomeController < ApplicationController
  def index
    @forecasts = Weather.last(10)
    @city_name = Weather.last.city if Weather.any?
  end
end
