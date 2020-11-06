FactoryBot.define do
  factory :account do
    lg_account_id { "LG-E-#{Faker::Name.initials(number: 3)}" }
    name { lg_account_id.split('-').last }
  end

  factory :account_contact do
    account
    user
  end

  factory :account_status do
    name { Faker::Types.rb_string }
    order { Faker::Types.rb_integer }
  end

  factory :iaa_gtc do
    account
    gtc_number { "LG#{Faker::Name.initials(number: 3)}FY210001" }
  end

  factory :iaa_order do
    iaa_gtc
    sequence(:order_number) { |i| i }
  end

  factory :iaa_status do
    name { Faker::Types.rb_string }
    order { Faker::Types.rb_integer }
  end

  factory :integration do
    account
    name { Faker::Internet.domain_word.titleize }
    issuer do
      agency = Faker::Name.initials(number: 3).downcase

      "urn:gov:gsa:openidconnect.profiles:sp:sso:#{agency}:#{name.downcase}"
    end
  end

  factory :integration_contact do
    integration
    user
  end

  factory :integration_status do
    name { Faker::Types.rb_string }
    order { Faker::Types.rb_integer }
  end

  factory :user do
    email { Faker::Internet.email }
  end
end
