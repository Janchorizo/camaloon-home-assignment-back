FactoryBot.define do
    factory :customization_type do
        name { Faker::Lorem.word }
        description { Faker::Coffee.notes }
        product_type
    end
end