require 'rails_helper'

RSpec.describe SoldTicket, type: :model do
  let(:sold_ticket) { FactoryBot.build(:sold_ticket) }

  it 'is not valid without a price' do
    sold_ticket.price = nil
    expect(sold_ticket).to_not be_valid
  end

  it 'is not valid without quantity' do
    sold_ticket.quantity = nil
    expect(sold_ticket).to_not be_valid
  end

  it 'is not valid wit quantity equal 0' do
    sold_ticket.quantity = nil
    expect(sold_ticket).to_not be_valid
  end
end
