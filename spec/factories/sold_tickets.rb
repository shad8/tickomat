FactoryBot.define do
  factory :sold_ticket do
    order { Order.first || association(:order) }
    ticket { Ticket.first || association(:ticket) }
    quantity { 1 }
    price { "9.99" }
  end
end
