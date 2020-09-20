FactoryBot.define do
  factory :order do
    event { Event.first || association(:event) }
    payment_state { 'payment_state_pending' }
    paid_amount { '9.99' }
  end
end
