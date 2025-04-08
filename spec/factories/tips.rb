FactoryBot.define do
  factory :tip do
    bill { 100 }
    tip_percentage { 10 }
    number_of_people { 2 }
  end
end
