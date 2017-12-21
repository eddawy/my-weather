class WeatherController < ApplicationController
  def new
  end
  
  def show
    city = params['city']
    country = params['country']
    q = [city, country].reject(&:blank?).join(',')
    params = {
      q: q,
      appid: ENV['APIID']
    }

    response = Typhoeus.get(ENV['WEATHER_API_URL'], params: params)
    data = JSON.parse(response.body)

    respond_to do |format|
      format.json  { render status: response.code, json: data }
    end
  end
end
