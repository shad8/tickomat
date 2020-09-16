FactoryBot.define do
  factory :ticket do
    selling_option { nil }
    quantity { 1 }
    price { "9.99" }
    event { Event.first || association(:event) }
  end
end
