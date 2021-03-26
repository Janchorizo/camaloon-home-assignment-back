FactoryBot.define do
    factory :customization_choice do
        name { Faker::Lorem.word }
        model_ref { Faker::Code.asin }
        description { Faker::Coffee.notes }
        extra_cost { Faker::Number.between(from: 1, to: 1000) }
        stock { Faker::Number.between(from: 1, to: 20) }
        manufacturer
        customization_type
    end
end