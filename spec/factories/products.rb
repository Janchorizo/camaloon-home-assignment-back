FactoryBot.define do
    sequence :productName do |n|
        "product_#{n}"
    end

    factory :product do
        name { generate(:productName) }
        description { Faker::Coffee.notes }
        base_price { Faker::Number.between(from: 1, to: 1000) }
        hidden { true }
        product_type
    end
end