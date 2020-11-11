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
end
