FactoryGirl.define do
  factory :post do
    body { Faker::ChuckNorris:fact }
    user
  end
end
