class ForecastController < ApplicationController
  skip_before_action :verify_authenticity_token

  def search
    client = OpenWeather::Client.new(
      api_key: ENV['API_KEY_OPENWEATHERMAP']
    )
    city_data = client.current_weather(city: params["locale"], units: 'metric', lang: 'pt_br')
    response = client.one_call(lat: city_data["coord"]["lat"], lon: city_data["coord"]["lon"],
      exclude: ['minutely', 'hourly'], units: 'metric', lang: 'pt_br')
    response.to_json
    respond_to do |format|
      format.json do
        render :json => response
      end
    end
  end
end