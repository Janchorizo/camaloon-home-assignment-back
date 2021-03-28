FactoryBot.define do
    sequence :customizationName do |n|
        "customization_#{n}"
    end

    factory :customization_type do
        name { generate(:customizationName) }
        description { Faker::Coffee.notes }
        product_type
    end
end