FactoryBot.define do
  factory :order do
    event { Event.first || association(:event) }
    payment_state { 'payment_state_pending' }
    paid_amout { '9.99' }
  end
end
