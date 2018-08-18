
describe 'weather service' do

  it 'instantiates' do
    expect(WeatherService.new('sydney')).not_to be_nil
    expect(WeatherService.new('sydney').city).to eq('sydney')
  end

  it '#get_city_code' do
    expect(WeatherService.new('sydney').get_city_code).to eq(1105779)
    expect(WeatherService.new('melbourne').get_city_code).to eq(1103816)
  end

  it '#get_forecast_data' do
    expect(WeatherService.new('sydney').get_forecast_data).to be_an_instance_of(Array)
  end

  it '#map_response_to_model' do
    forecasts = WeatherService.new('sydney').get_forecast_data
    expect(WeatherService.new('sydney').map_response_to_model(forecasts)).to be_an_instance_of(Array)
    expect(WeatherService.new('sydney').map_response_to_model(forecasts).first).to be_an_instance_of(Weather)
    expect(WeatherService.new('sydney').map_response_to_model(forecasts).count).to eq(10)
  end

  it '#get_forecast' do
    expect(WeatherService.new('sydney').get_forecast).to be_an_instance_of(Array)
    expect(WeatherService.new('sydney').get_forecast.first).to have_attributes(:city, :high, :low, :description)
  end
end
