require 'rails_helper'

RSpec.describe IAAStatus, type: :model do
  describe 'validations' do
    subject { build(:iaa_status) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
    it { is_expected.to validate_presence_of(:order) }
    it { is_expected.to validate_uniqueness_of(:order) }
  end

  describe 'associations' do
    subject { build(:iaa_status) }

    it { is_expected.to have_many(:iaa_gtcs).dependent(:nullify) }
    it { is_expected.to have_many(:iaa_orders).dependent(:nullify) }
  end

  describe 'ordering' do
    it { is_expected.to have_implicit_order_column(:order) }

    it 'orders by the "order" column by default' do
      create(:iaa_status, name: 'foo', order: 100)
      create(:iaa_status, name: 'bar', order: 0)

      expect(described_class.pluck(:name)).to eq(%w[bar foo])
    end
  end

  describe '#partner_name' do
    it 'returns the attribute if set' do
      iaa_status = build(:iaa_status, name: 'foo', partner_name: 'bar')

      expect(iaa_status.partner_name).to eq('bar')
    end

    it 'falls back to the name if no partner_name set' do
      iaa_status = build(:iaa_status, name: 'foo', partner_name: nil)

      expect(iaa_status.partner_name).to eq('foo')
    end
  end
end
