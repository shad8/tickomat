FactoryBot.define do
  factory :ticket do
    selling_option { nil }
    quantity { 1 }
    price { "9.99" }
    event { Event.first || association(:event) }

    factory :free_ticket, class: FreeTicket do
      price { "0.00" }
    end

    factory :regular_ticket, class: RegularTicket do
    end

    factory :vip_ticket, class: VipTicket do
    end
  end
end
