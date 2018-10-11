FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    address { Faker::Address.full_address }
    phone { Faker::PhoneNumber.phone_number }
    password {Faker::Internet.password}
  end
end
