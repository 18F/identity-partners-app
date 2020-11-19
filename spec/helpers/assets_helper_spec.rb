require 'rails_helper'

RSpec.describe AssetsHelper, type: :helper do
  describe '.identity_asset_path' do
    it 'prepends the passed path with the appropriate subdirectory' do
      expect(helper.identity_asset_path('foo/bar')).to \
        eq('identity-style-guide/dist/assets/foo/bar')
    end
  end
end
