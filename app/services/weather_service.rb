
class WeatherService
  attr_accessor :city

  def initialize(city)
    @city = city.downcase
  end

  def get_city_code #WOEID Lookup
    city_codes ={ 'sydney'=> 2147714, 'melbourne' => 7839805}
    city_codes[@city]
  end

  def get_forecast_data
    city_code = get_city_code

    # Note: As of Thursday, Jan. 3, 2019, the query.yahooapis.com for Yahoo Weather API is retired.
    # uri = URI("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%3D#{city_code}&format=json")
    # replacing with https://openweathermap.org/forecast5
    # How to start https://openweathermap.org/appid?source=post_page---------------------------

    api_key = ENV['OPEN_WEATHER_MAP_API_KEY']

    uri = URI("http://api.openweathermap.org/data/2.5/forecast?id=#{city_code}&appid=#{api_key}")
    response = Net::HTTP.get(uri) #return String

    json = JSON.parse(response) #return json object
    json['list'][0...6]#return array of forcast, select only first 7 elements for the week
  end

  def map_response_to_model(forecasts)
    #map the response to Weather model
    weather_collector = []

    forecasts.map do |forecast|
      weather = Weather.create!(
        city: @city,
        date: forecast['dt_txt'],
        day: forecast['weather'][0]['main'],
        high: forecast['main']['temp_max'],
        low: forecast['main']['temp_min'],
        description: forecast['weather'][0]['description']
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
