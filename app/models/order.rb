class Order < ApplicationRecord
  belongs_to :event

  enum payment_state: {
    payment_state_pending: 'payment_state_pending',
    payment_state_awaiting_approval: 'payment_state_awaiting_approval',
    payment_state_paid: 'payment_state_paid'
  }
end
