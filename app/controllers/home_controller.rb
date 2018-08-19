class HomeController < ApplicationController
  def index
    @forecasts = Weather.last(10)
  end
end
