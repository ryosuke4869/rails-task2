FactoryBot.define do
  factory :reservation do
    user { nil }
    room { nil }
    start_date { "2022-07-24 16:31:32" }
    end_date { "2022-07-24 16:31:32" }
    persons { 1 }
  end
end
