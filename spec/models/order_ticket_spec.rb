require 'rails_helper'

RSpec.describe OrderTicket, type: :model do
  let(:order_ticket) { FactoryBot.build(:order_ticket) }

  it 'is not valid without a price' do
    order_ticket.price = nil
    expect(order_ticket).to_not be_valid
  end

  it 'is not valid without quantity' do
    order_ticket.quantity = nil
    expect(order_ticket).to_not be_valid
  end

  it 'is not valid wit quantity equal 0' do
    order_ticket.quantity = nil
    expect(order_ticket).to_not be_valid
  end
end
