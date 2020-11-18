class Integration < ApplicationRecord
  belongs_to :account
  belongs_to :integration_status, optional: true

  has_many :integration_contacts, dependent: :destroy
  has_many :contacts, through: :integration_contacts, source: :user
  has_many :integration_usages, dependent: :nullify

  validates :issuer, presence: true,
                     uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :protocol, presence: true

  enum protocol: { oidc: 'oidc', saml: 'saml' }
end
