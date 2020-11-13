# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Rails.application.config.agencies.values.pluck("name").each do |str|
#   Agency.find_or_create_by(name: str)
# end

if Rails.env.development? || Rails.env.test?
  User.find_or_create_by email: 'test1@test.com' do |user|
    user.admin = true
  end
end

u1 = User.create(
  email: 'patty.partner@dot.gov',
  first_name: 'Patty',
  last_name: 'Partner',
  title: 'CISO',
  phone: '202-222-2222',
)

u2 = User.create(
  email: 'sally.salmon@dot.gov',
  first_name: 'Sally',
  last_name: 'Salmon',
  title: 'Program Manager',
  phone: '202-222-2222',
)

u3 = User.create(
  email: 'rick.richshaw@dot.gov',
  first_name: 'Rick',
  last_name: 'Rickshaw',
  title: 'Developer',
  phone: '202-222-2222',
)

# Create statuses
{
  'intake' => 0,
  'in progress' => 100,
  'active' => 200,
  'lost' => 300
}.each { |name, order| AccountStatus.find_or_create_by!(name: name, order: order) }

{
  'intake' => 0,
  'in progress' => 100,
  'TTS bizops' => 200,
  'active' => 300,
  'expired' => 400,
  'cancelled' => 500
}.each { |name, order| IAAStatus.find_or_create_by!(name: name, order: order) }

{
  'intake' => 0,
  'in progress' => 100,
  'config live' => 200,
  'app live' => 300,
  'decommissioned' => 400,
  'cancelled' => 500
}.each { |name, order| IntegrationStatus.find_or_create_by!(name: name, order: order) }

# Import agencies
agency_hash = YAML.load(File.read('agencies.yml'))["production"]
agency_hash.each do |lg_id, attrs|
  Agency.find_or_create_by!(lg_identifier: lg_id, name: attrs["name"], abbreviation: attrs["abbreviation"])
end

# a1 = App.create(
#   lg_app_id: '78937628',
#   name: 'FMCSA Drug & Alcohol Clearinghouse',
#   description: 'The Clearinghouse is a secure online database that gives employers, the Federal Motor Carrier Safety Administration (FMCSA), State Driver Licensing Agencies (SDLAs), and State law enforcement personnel real-time information about commercial driver’s license (CDL) and commercial learner’s permit (CLP) holders’ drug and alcohol program violations.',
#   ial: 1,
#   lg_client_ids: ['9823745892375.login.gov'],
#   identity_protocol: 'oidc',
#   approved: true,
#   live: true,
#   live_on: Date.new(2019, 4, 27),
#   url: 'https://clearinghouse.fmcsa.dot.gov',
#   users_in_pop: 54_902,
#   users_lifetime: 763_187,
#   auths_in_pop: 219_608,
#   auths_lifetime: 3_052_748
# )
#
# a2 = App.create(
#   lg_app_id: '907647823',
#   name: 'Robo Car Registry',
#   description: '',
#   ial: 2
# )

Account.create(
  lg_identifier: 'LG-E-DOT',
  name: 'DOT / CISO',
  agency: Agency.find_by(abbreviation: 'DOT'),
  pricing: 2,
  became_partner: Date.new(2019, 3, 12),
  # users: [u1, u2, u3],
  # apps: [a1, a2]
)

Account.create(lg_identifier: 'LG-E-DOL', name: 'DOL / OCIO', agency: Agency.find_by(abbreviation: 'DOL'))
Account.create(lg_identifier: 'LG-E-HHS', name: 'HHS / PSC', agency: Agency.find_by(abbreviation: 'HHS'))
Account.create(lg_identifier: 'LG-E-HHS', name: 'HHS / PSC', agency: Agency.find_by(abbreviation: 'HHS'))
