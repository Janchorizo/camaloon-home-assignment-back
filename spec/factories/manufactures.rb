FactoryBot.define do
    factory :manufacturer do
        name { Faker::Lorem.word }
        cif { Faker::Code.asin }
        phone { Faker::Number.number(digits: 9) }
        email { Faker::Internet.email }
        website { Faker::Internet.domain_name }
        billing_address { Faker::Address.full_address }
    end
end