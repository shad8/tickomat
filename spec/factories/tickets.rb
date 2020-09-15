FactoryBot.define do
  factory :ticket do
    selling_option { "MyString" }
    quantity { 1 }
    price { "9.99" }
    event { nil }
  end
end
