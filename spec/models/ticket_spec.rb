require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it 'define selling_options' do
    selling_options = %w(selling_option_even selling_option_all_together selling_option_avoid_one)
    expect(Ticket.selling_options.keys).to eq selling_options
  end

  shared_examples 'common ticket behavior' do |ticket_type|
    it 'is not valid when quantity equal 0' do
      ticket = FactoryBot.build(ticket_type, quantity: 0)
      expect(ticket).to_not be_valid
    end

    it 'is not valid without a quantity' do
      ticket = FactoryBot.build(ticket_type, quantity: nil)
      expect(ticket).to_not be_valid
    end
  end

  context 'when ticket is free' do
    include_examples 'common ticket behavior', :free_ticket

    let(:ticket) { FactoryBot.build(:free_ticket) }

    it 'is not valid without a different price than 0' do
      ticket.price = 10.99
      expect(ticket).to_not be_valid
    end

    it 'is not include gift package' do
      expect(ticket.include_gift_package?).to be_falsey
    end
  end

  context 'when ticket is regular' do
    include_examples 'common ticket behavior', :regular_ticket

    let(:ticket) { FactoryBot.build(:regular_ticket) }

    it 'is not valid without a price equal 0' do
      ticket.price = 0
      expect(ticket).to_not be_valid
    end

    it 'is not include gift package' do
      expect(ticket.include_gift_package?).to be_falsey
    end
  end

  context 'when ticket is vip' do
    include_examples 'common ticket behavior', :vip_ticket

    let(:ticket) { FactoryBot.build(:vip_ticket) }

    it 'is not valid without a price equal 0' do
      ticket.price = 0
      expect(ticket).to_not be_valid
    end

    it 'is not include gift package' do
      expect(ticket.include_gift_package?).to be_truthy
    end
  end
end
