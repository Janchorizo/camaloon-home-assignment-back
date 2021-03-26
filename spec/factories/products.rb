FactoryBot.define do
    factory :product do
        name { Faker::Lorem.word }
        description { Faker::Coffee.notes }
        base_price { Faker::Number.between(from: 1, to: 1000) }
        hidden { true }
        product_type
    end
end