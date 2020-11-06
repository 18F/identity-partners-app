require 'rails_helper'

RSpec.describe AccountStatus, type: :model do
  describe 'validations' do
    subject { build(:account_status) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
    it { is_expected.to validate_presence_of(:order) }
    it { is_expected.to validate_uniqueness_of(:order) }
  end

  describe 'associations' do
    subject { build(:account_status) }

    it { is_expected.to have_many(:accounts).dependent(:nullify) }
  end

  describe 'ordering' do
    it { is_expected.to have_implicit_order_column(:order) }

    it 'orders by the "order" column by default' do
      create(:account_status, name: 'foo', order: 100)
      create(:account_status, name: 'bar', order: 0)

      expect(described_class.pluck(:name)).to eq(%w[bar foo])
    end
  end
end
