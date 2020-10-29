FactoryBot.define do
  factory :account do
    lg_account_id { "LG-E-#{Faker::Name.initials(number: 3)}" }
    name { lg_account_id.split('-').last }
  end

  factory :iaa do
    account
    number { "LG#{Faker::Name.initials(number: 3)}FY210001" }
  end

  factory :user do
    email { Faker::Internet.email }
  end
end
