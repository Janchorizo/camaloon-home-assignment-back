FactoryBot.define do
    factory :product_type do
        name { Faker::Lorem.word }
        description { Faker::Coffee.notes }
        hidden { true }
    end
end