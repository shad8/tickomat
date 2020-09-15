FactoryBot.define do
  factory :event do
    name { 'Lorem ipsum' }
    started_at { DataTime.current - 1.day }
  end
end
