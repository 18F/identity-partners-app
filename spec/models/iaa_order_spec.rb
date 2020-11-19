require 'rails_helper'

RSpec.describe IAAOrder, type: :model do
  describe 'validations' do
    subject { build(:iaa_order) }

    it { is_expected.to validate_presence_of(:order_number) }
    it { is_expected.to validate_numericality_of(:order_number).is_greater_than(0) }

    describe 'order_number' do
      it 'must be unique scoped to IAA' do
        order = create(:iaa_order, order_number: 1)
        other_order = build(:iaa_order, iaa_gtc: order.iaa_gtc, order_number: 1)
        expect(other_order).not_to be_valid
      end
    end

    it { is_expected.to validate_presence_of(:mod_number) }
    it { is_expected.to validate_numericality_of(:mod_number).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_presence_of(:estimated_amount) }
    it { is_expected.to validate_numericality_of(:estimated_amount).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_presence_of(:ial2_users) }
    it { is_expected.to validate_numericality_of(:ial2_users).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_presence_of(:platform_fee) }
    it { is_expected.to validate_numericality_of(:platform_fee).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_presence_of(:consulting_hours) }
    it { is_expected.to validate_numericality_of(:consulting_hours).is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    subject { build(:iaa_order) }

    it { is_expected.to belong_to(:iaa_gtc) }
    it { is_expected.to belong_to(:iaa_status).optional }
    it { is_expected.to have_many(:integration_usages).dependent(:destroy) }
  end

  describe '#name' do
    it 'generates the appropriate IAA Order string' do
      gtc = build(:iaa_gtc, gtc_number: 'FOOBAR')
      order = build(:iaa_order, iaa_gtc: gtc, order_number: 1, mod_number: 2)

      expect(order.name).to eq('FOOBAR-0001-0002')
    end
  end

  describe '#cost_to_date' do
    let(:iaa_order) { create(:iaa_order, platform_fee: 50_000, ial2_users: 1000, consulting_hours: 20) }

    before do
      allow(Figaro.env).to receive(:per_auth_cost).and_return("0.075")
      allow(Figaro.env).to receive(:per_ial2_user_cost).and_return("5")
      allow(Figaro.env).to receive(:per_consulting_hour_cost).and_return("275")
      create(:integration_usage, iaa_order: iaa_order, auths: 1000)
      create(:integration_usage, iaa_order: iaa_order, auths: 2000)
    end

    it 'returns the obligated amount based on current usage' do
      # based on numbers above, $50 platform fee, 3000 IAL1 across all
      # integrations, 1000 IAL2 users, 20 consulting hours
      expect(iaa_order.cost_to_date).to eq(60_725)
    end
  end
end
