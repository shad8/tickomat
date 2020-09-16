require 'rails_helper'

RSpec.describe "Api::V1::Events", type: :request do
  describe 'GET #index' do
    let!(:events_list) do
      [
        FactoryBot.create(:event),
        FactoryBot.create(:event),
        FactoryBot.create(:event)
      ]
    end

    before(:each) { get '/api/v1/events' }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'response contains event list' do
      json_response = JSON.parse(response.body)['data']
      expect(json_response).to be_a(Array)
      expect(json_response.size).to eq events_list.size
    end
  end

  describe 'GET #show' do
    let!(:event) do
      FactoryBot.create(:event)
    end

    before(:each) { get "/api/v1/events/#{event.id}" }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'response contains event list' do
      json_response = JSON.parse(response.body)['data']
      expect(json_response['id'].to_i).to eq event.id
      expect(json_response['attributes'].keys).to match_array %w(started-at)
    end
  end
end
