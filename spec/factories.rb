FactoryBot.define do
  factory :account do
    lg_account_id { "LG-E-#{Faker::Name.initials(number: 3)}" }
    name { lg_account_id.split('-').last }
  end

  factory :iaa_gtc do
    account
    gtc_number { "LG#{Faker::Name.initials(number: 3)}FY210001" }
  end

  factory :iaa_order do
    iaa_gtc
    sequence(:order_number) { |i| i }
  end

  factory :integration do
    account
    name { Faker::Internet.domain_word.titleize }
    issuer do
      agency = Faker::Name.initials(number: 3).downcase

      "urn:gov:gsa:openidconnect.profiles:sp:sso:#{agency}:#{name.downcase}"
    end
  end

  factory :user do
    email { Faker::Internet.email }
  end
end
