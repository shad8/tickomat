require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it 'is not valid without a quantity' do
    ticket = FactoryBot.build(:ticket, quantity: nil)
    expect(ticket).to_not be_valid
  end

  it 'is not valid when quantity equal 0' do
    ticket = FactoryBot.build(:ticket, quantity: 0)
    expect(ticket).to_not be_valid
  end

  it 'is not valid without a price' do
    ticket = FactoryBot.build(:ticket, price: nil)
    expect(ticket).to_not be_valid
  end

  it 'define selling_options' do
    selling_options = %w(selling_option_even selling_option_all_together selling_option_avoid_one)
    expect(Ticket.selling_options.keys).to eq selling_options
  end
end
