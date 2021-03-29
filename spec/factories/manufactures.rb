FactoryBot.define do
    sequence :manufacturerName do |n|
        "manufacturer_#{n}"
    end
    sequence :manufacturerCif do |n|
        "cif_#{n}"
    end

    factory :manufacturer do
        name { generate(:manufacturerName) }
        cif { generate(:manufacturerCif) }
        phone { Faker::Number.number(digits: 9) }
        email { Faker::Internet.email }
        website { Faker::Internet.domain_name }
        billing_address { Faker::Address.full_address }
    end
end