require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'define payment_states' do
    payment_states = %w(payment_state_pending payment_state_awaiting_approval payment_state_paid)
    expect(Order.payment_states.keys).to eq payment_states
  end
end
