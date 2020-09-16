FactoryBot.define do
  factory :event do
    name { 'Lorem ipsum' }
    started_at { DateTime.current - 1.day }
  end
end
