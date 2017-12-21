class WeatherController < ApplicationController
  def new
  end
  
  def show
    city = params['city']
    country = params['country']
    q = [city, country].reject(&:blank?).join(',')
    cache_key = q.downcase
    response = REDIS.get(cache_key)
   
    if response.blank?
      req_params = {
        q: q,
        appid: ENV['APIID']
      }

      response = Typhoeus.get(ENV['WEATHER_API_URL'], params: req_params)
      status = response.code
      data = JSON.parse(response.body)

      REDIS.set(cache_key, { status: status, data: data }.to_json, ex: 1.day)
    else
      response = JSON.parse(response)
      status = response['status']
      data = response['data']
    end

    respond_to do |format|
      format.json  { render status: status, json: data }
    end
  end
end
