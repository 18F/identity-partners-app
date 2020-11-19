require 'factory_bot'

# Set up admin user in dev
if Rails.env.development?
  User.find_or_create_by email: 'test1@test.com' do |user|
    user.admin = true
  end
end

# Create statuses - can be updated down the line
{
  'intake' => 0,
  'in progress' => 100,
  'active' => 200,
  'lost' => 300
}.each { |name, order| AccountStatus.find_or_create_by!(name: name, order: order) }

{
  'intake' => { order: 0, partner_name: 'pending' },
  'in progress' => { order: 100, partner_name: 'pending' },
  'TTS bizops' => { order: 200, partner_name: 'pending' },
  'active' => { order: 300 },
  'expired' => { order: 400 },
  'cancelled' => { order: 500 }
}.each { |name, hash| IAAStatus.find_or_create_by!(name: name, order: hash[:order], partner_name: hash[:partner_name]) }

{
  'intake' => { order: 0, partner_name: 'pending' },
  'in progress' => { order: 100, partner_name: 'pending' },
  'config live' => { order: 200, partner_name: 'live' },
  'app live' => { order: 300, partner_name: 'live' },
  'decommissioned' => { order: 400 },
  'cancelled' => { order: 500 }
}.each { |name, hash| IntegrationStatus.find_or_create_by!(name: name, order: hash[:order], partner_name: hash[:partner_name]) }

# Import agencies
agency_hash = YAML.load(File.read('agencies.yml'))["production"]
agency_hash.each do |lg_id, attrs|
  Agency.find_or_create_by!(lg_identifier: lg_id, name: attrs["name"], abbreviation: attrs["abbreviation"])
end

# utility methods
def random_record(klass)
  offset = rand(klass.count)
  klass.offset(offset).first
end

def dummy_user(agency)
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  domain = agency.abbreviation.downcase.gsub(/\s/, '-') + "." + (rand > 0.5 ? "mil" : "gov")
  email = "#{first_name}.#{last_name}@#{domain}"

  User.create!(
    first_name: first_name,
    last_name: last_name,
    email: email,
    title: Faker::Company.profession,
    phone: Faker::PhoneNumber.phone_number
  )
end

# data creation methods
def new_account
  FactoryBot.create(
    :account,
    agency: random_record(Agency),
    account_status: random_record(AccountStatus)
  )
end

def new_account_contact(account)
  FactoryBot.create(
    :account_contact,
    account: account,
    user: dummy_user(account.agency)
  )
end

def new_iaa_gtc(account)
  return account.iaa_gtcs.first if account.iaa_gtcs.count.positive?

  start_date = Time.zone.today - rand(180).days

  FactoryBot.create(
    :iaa_gtc,
    account: account,
    iaa_status: random_record(IAAStatus),
    start_date: start_date,
    end_date: start_date + 5.years - 1.day
  )
end

def new_iaa_order(iaa_gtc)
  return iaa_gtc.iaa_orders.first if iaa_gtc.iaa_orders.count.positive?

  FactoryBot.create(
    :iaa_order,
    iaa_gtc: iaa_gtc,
    iaa_status: random_record(IAAStatus),
    start_date: iaa_gtc.start_date,
    end_date: iaa_gtc.start_date + 1.year - 1.day,
    platform_fee: rand > 0.5 ? 35_000 : 50_000,
    ial2_users: rand(25_000)
  )
end

def new_integration(account)
  go_live = account.iaa_orders.first.start_date + rand(12).weeks

  FactoryBot.create(
    :integration,
    account: account,
    integration_status: random_record(IntegrationStatus),
    go_live: go_live,
    prod_deploy: go_live - rand(3).weeks,
    url: Faker::Internet.url
  )
end

def new_integration_contact(integration)
  FactoryBot.create(
    :integration_contact,
    integration: integration,
    user: dummy_user(integration.account.agency)
  )
end

NUM_ACCOUNTS = ENV.fetch("NUM_ACCOUNTS", 10)
NUM_CONTACTS = ENV.fetch("NUM_CONTACTS", 5)
NUM_INTEGRATIONS = ENV.fetch("NUM_INTEGRATIONS", 30)

# create accounts and account contacts
NUM_ACCOUNTS.times do
  account = new_account
  rand(NUM_CONTACTS).times { new_account_contact(account) }
end

# create integrations and integration contacts, each one requires that the account have an IAA
NUM_INTEGRATIONS.times do
  account = random_record(Account)

  iaa_gtc = new_iaa_gtc(account)
  iaa_order = new_iaa_order(iaa_gtc)

  integration = new_integration(account)
  FactoryBot.create(:integration_usage, integration: integration, iaa_order: iaa_order, auths: rand(200_000))
  rand(NUM_CONTACTS).times { new_integration_contact(integration) }
end

# Add estimated IAA amounts based on current usage
IAAOrder.all.each do |iaa_order|
  iaa_order.update!(estimated_amount: iaa_order.cost_to_date / rand)
  iaa_order.iaa_gtc.update!(estimated_amount: iaa_order.estimated_amount * rand(8))
end
