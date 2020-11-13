require 'rails_helper'

RSpec.describe Agency, type: :model do
  describe 'validations' do
    subject { build(:agency) }

    it { is_expected.to validate_presence_of(:abbreviation) }
    it { is_expected.to validate_uniqueness_of(:abbreviation).case_insensitive }
    it { is_expected.to validate_presence_of(:lg_identifier) }
    it { is_expected.to validate_uniqueness_of(:lg_identifier) }
    it { is_expected.to validate_numericality_of(:lg_identifier).is_greater_than(0) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'associations' do
    subject { build(:agency) }

    it { is_expected.to have_many(:accounts) }
  end

  describe 'ordering' do
    it 'orders by the "name" column by default' do
      create(:agency, name: 'Foo', abbreviation: 'ABC', lg_identifier: 1)
      create(:agency, name: 'Bar', abbreviation: 'DEF', lg_identifier: 2)

      expect(described_class.pluck(:name)).to eq(%w[Bar Foo])
    end
  end
end
