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

    it 'response contains event list' do
      meta_data = JSON.parse(response.body)['meta']
      expect(meta_data['current-page']).to eq 1
      expect(meta_data['total-pages']).to eq 1
      expect(meta_data['total-count']).to eq events_list.size
    end
  end

  describe 'GET #show' do
    let(:event_attributes) do
      %w(started-at available-ticket-quantity all-ticket-quantity)
    end

    let(:ticket_attributes) do
      %w(price all-ticket-quantity available-ticket-quantity selling-option)
    end

    let!(:event) { FactoryBot.create(:event) }
    let!(:free_ticket) { FactoryBot.create(:free_ticket, quantity: 20, event: event) }
    let!(:regular_ticket) { FactoryBot.create(:regular_ticket, quantity: 10, event: event) }
    let!(:vip_ticket) { FactoryBot.create(:vip_ticket, quantity: 5, event: event) }

    before(:each) { get "/api/v1/events/#{event.id}" }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'response event' do
      json_response = JSON.parse(response.body)['data']
      expect(json_response['id'].to_i).to eq event.id
      expect(json_response['attributes'].keys).to match_array event_attributes
      expect(json_response['attributes']['all-ticket-quantity']).to eq 35
      expect(json_response['attributes']['available-ticket-quantity']).to eq 35
    end

    {
      'free-ticket' => { quantity: 20, available: 20 },
      'regular-ticket'=> { quantity: 10, available: 10 },
      'vip-ticket' => {quantity: 5, available: 5 },
    }.each do |ticket_name, ticket_data|
      it "include information about #{ticket_name}" do
        json_response = JSON.parse(response.body)['included']
        ticket = json_response.detect { |t| t['type'] == "#{ticket_name}s" }

        expect(ticket['attributes'].keys).to match_array ticket_attributes
        expect(ticket['attributes']['all-ticket-quantity']).to eq ticket_data[:quantity]
        expect(ticket['attributes']['available-ticket-quantity']).to eq ticket_data[:available]
      end
    end
  end
end
