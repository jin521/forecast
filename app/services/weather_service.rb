
class WeatherService
  attr_accessor :city

  def initialize(city)
    @city = city.downcase
  end

  def get_city_code #WOEID Lookup
    city_codes ={ 'sydney'=> 1105779, 'melbourne' => 1103816}
    city_codes[@city]
  end

  def get_forecast_data
    city_code = get_city_code

    uri = URI("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%3D#{city_code}&format=json")
    response = Net::HTTP.get(uri) #return String

    json = JSON.parse(response) #return json object
    json['query']['results']['channel']['item']['forecast'] #return array of forcast
  end

  def map_response_to_model(forecasts)
    #map the response to Weather model
    weather_collector = []

    forecasts.map do |forecast|
      weather = Weather.create!(
        city: @city,
        date: forecast['date'],
        day: forecast['day'],
        high: forecast['high'],
        low: forecast['low'],
        description: forecast['text']
      )
      weather_collector << weather
    end
    weather_collector
  end

  def get_forecast
    #Todo: Caching: depending on requirements it might be useful to read exisiting data from db instead of sending another http request
    forecasts = get_forecast_data
    map_response_to_model(forecasts)
  end
end
