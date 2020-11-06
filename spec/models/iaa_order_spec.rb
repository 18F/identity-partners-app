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
    it { is_expected.to validate_numericality_of(:estimated_amount).is_greater_than_or_equal_to(0).allow_nil }
    it { is_expected.to validate_numericality_of(:billed_amount).is_greater_than_or_equal_to(0).allow_nil }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:iaa_gtc) }
    it { is_expected.to belong_to(:iaa_status).optional }
  end

  describe '#name' do
    it 'generates the appropriate IAA Order string' do
      gtc = build(:iaa_gtc, gtc_number: 'FOOBAR')
      order = build(:iaa_order, iaa_gtc: gtc, order_number: 1, mod_number: 2)

      expect(order.name).to eq('FOOBAR-0001-0002')
    end
  end
end
