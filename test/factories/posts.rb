FactoryGirl.define do
  factory :post do
    body { Faker::ChuckNorris.fact[0...160] }
    user
  end
end
