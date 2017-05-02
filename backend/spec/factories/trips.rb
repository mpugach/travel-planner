FactoryGirl.define do
  factory :trip do
    user
    end_date    { Date.tomorrow }
    comment     { FFaker::HealthcareIpsum.sentence }
    start_date  { Date.yesterday }
    destination { FFaker::Address.city }
  end
end
