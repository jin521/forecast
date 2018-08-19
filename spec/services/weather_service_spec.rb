require 'spec_helper'

describe 'weather service' do
  subject(:weather_service) { WeatherService.new('sydney') }

  it 'instantiates' do
    expect(weather_service).not_to be_nil
    expect(weather_service.city).to eq('sydney')
  end

  it '#get_city_code' do
    expect(weather_service.get_city_code).to eq(1105779)
    expect(WeatherService.new('melbourne').get_city_code).to eq(1103816)
  end

  it '#get_forecast_data' do
    expect(weather_service.get_forecast_data).to be_an_instance_of(Array)
  end

  it '#map_response_to_model' do
    forecasts = weather_service.get_forecast_data
    expect(weather_service.map_response_to_model(forecasts)).to be_an_instance_of(Array)
    expect(weather_service.map_response_to_model(forecasts).first).to be_an_instance_of(Weather)
    expect(weather_service.map_response_to_model(forecasts).count).to eq(10)
  end

  it '#get_forecast' do
    expect(weather_service.get_forecast).to be_an_instance_of(Array)
    expect(weather_service.get_forecast.first).to be_an_instance_of(Weather)
    expect(weather_service.get_forecast.first).to respond_to(:city, :high, :low, :description, :day, :date)
  end
end
