require 'spec_helper'
require 'rails_helper'

RSpec.describe WeatherController do
  describe 'POST /show' do
    let(:city) { 'London' }
    let(:country) { 'uk' }
    let(:wrong_city) { 'kkkkk' }
    let(:wrong_country) { 'vvvvv' }

    context 'when only correct city is sent' do
      it 'returns the weather' do
        post 'show', { city: city, country: '', format: :json }
        expect(response).to have_http_status(200)
      end
    end

    context 'when correct city and country are sent' do
      it 'returns the weather' do
       post 'show', { city: city, country: country, format: :json }
       expect(response).to have_http_status(200)
      end
    end

    context 'when wrong city is sent' do
      it 'returns error msg' do
        post 'show', { city: wrong_city, country: '', format: :json }
        expect(response).to have_http_status(404)
      end
    end

    context 'when wrong city and wrong country are sent' do
      it 'returns error msg' do
        post 'show', { city: wrong_city, country: wrong_country, format: :json }
        expect(response).to have_http_status(404)
      end
    end

    context 'when wrong city and correct country are sent' do
      it 'returns error msg' do
        post 'show', { city: wrong_city, country: country, format: :json }
        expect(response).to have_http_status(404)
      end
    end

    context 'when correct city and wrong country are sent' do
      it 'return error msg' do
        post 'show', { city: city, country: wrong_country, format: :json }
        expect(response).to have_http_status(200)
      end
    end
  end
end
