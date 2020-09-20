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
      %w(started-at available-ticket-quantity all-ticket-quantity ticket-sales-open)
    end

    let(:ticket_attributes) do
      %w(price all-ticket-quantity available-ticket-quantity selling-option)
    end

    let!(:event) { FactoryBot.create(:event, started_at: DateTime.current + 1.day) }
    let!(:free_ticket) { FactoryBot.create(:free_ticket, quantity: 20, event: event) }
    let!(:regular_ticket) { FactoryBot.create(:regular_ticket, quantity: 10, event: event) }
    let!(:vip_ticket) { FactoryBot.create(:vip_ticket, quantity: 5, event: event) }

    let!(:event_2) { FactoryBot.create(:event, started_at: DateTime.current - 1.day) }
    let!(:regular_ticket_2) { FactoryBot.create(:regular_ticket, quantity: 10, event: event_2) }

    it 'returns http success' do
      get "/api/v1/events/#{event.id}"
      expect(response).to have_http_status(:success)
    end

    context 'when event has available tickets' do
      context 'when event not start yet' do
        subject do
          get "/api/v1/events/#{event.id}"
          JSON.parse(response.body)
        end

        it 'response event with available tickets selling' do
          json_response = subject['data']
          expect(json_response['id'].to_i).to eq event.id
          expect(json_response['attributes'].keys).to match_array event_attributes
          expect(json_response['attributes']['ticket-sales-open']).to be_truthy
        end

        context 'when no ticket has been sold'do
          it 'event has correct information about ticket' do
            expect(subject['data']['attributes']['all-ticket-quantity']).to eq 35
            expect(subject['data']['attributes']['available-ticket-quantity']).to eq 35
          end

          {
            'free-ticket' => { quantity: 20, available: 20 },
            'regular-ticket'=> { quantity: 10, available: 10 },
            'vip-ticket' => {quantity: 5, available: 5 },
          }.each do |ticket_name, ticket_data|
            it "include information about #{ticket_name}" do
              ticket = subject['included'].detect { |t| t['type'] == "#{ticket_name}s" }

              expect(ticket['attributes'].keys).to match_array ticket_attributes
              expect(ticket['attributes']['all-ticket-quantity']).to eq ticket_data[:quantity]
              expect(ticket['attributes']['available-ticket-quantity']).to eq ticket_data[:available]
            end
          end
        end

        context 'when some tickets have been sold'do
          let!(:order) { FactoryBot.create(:order, event: event) }
          let!(:sold_tickets) do
            FactoryBot.create(:sold_ticket, quantity: 20, order: order, ticket: free_ticket)
            FactoryBot.create(:sold_ticket, quantity: 5, order: order, ticket: regular_ticket)
          end

          it 'event has correct information about ticket' do
            get "/api/v1/events/#{event.id}"
            expect(subject['data']['attributes']['all-ticket-quantity']).to eq 35
            expect(subject['data']['attributes']['available-ticket-quantity']).to eq 10
          end

          {
            'free-ticket' => { quantity: 20, available: 0 },
            'regular-ticket'=> { quantity: 10, available: 5 },
            'vip-ticket' => {quantity: 5, available: 5 },
          }.each do |ticket_name, ticket_data|
            it "include information about #{ticket_name}" do
              ticket = subject['included'].detect { |t| t['type'] == "#{ticket_name}s" }

              expect(ticket['attributes'].keys).to match_array ticket_attributes
              expect(ticket['attributes']['all-ticket-quantity']).to eq ticket_data[:quantity]
              expect(ticket['attributes']['available-ticket-quantity']).to eq ticket_data[:available]
            end
          end
        end
      end

      context 'when event start' do
        before(:each) { get "/api/v1/events/#{event_2.id}" }

        it 'response event with closed ticket sales' do
          json_response = JSON.parse(response.body)['data']
          expect(json_response['id'].to_i).to eq event_2.id
          expect(json_response['attributes'].keys).to match_array event_attributes
          expect(json_response['attributes']['all-ticket-quantity']).to eq 10
          expect(json_response['attributes']['available-ticket-quantity']).to eq 10
          expect(json_response['attributes']['ticket-sales-open']).to be_falsey
        end
      end
    end
  end
end
