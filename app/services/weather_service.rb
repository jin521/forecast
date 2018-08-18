
class WeatherService
  attr_accessor :city

  def initialize(city)
    @city = city.downcase
  end

  def get_city_code #WOEID Lookup
    city_codes ={ 'sydney'=> 1105779, 'melbourne' => 1103816}
    city_codes[@city]
  end










end
