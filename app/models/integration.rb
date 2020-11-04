class Integration < ApplicationRecord
  belongs_to :account, dependent: :destroy

  validates :issuer, presence: true,
                     uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :protocol, presence: true

  enum protocol: { oidc: 'oidc', saml: 'saml' }
end
