class Account < ApplicationRecord
  belongs_to :account_status, optional: true
  belongs_to :agency

  has_many :account_contacts, dependent: :destroy
  has_many :contacts, through: :account_contacts, source: :user
  has_many :iaa_gtcs, dependent: :destroy
  has_many :iaa_orders, through: :iaa_gtcs
  has_many :integrations, dependent: :destroy

  validates :lg_identifier, presence: true,
                            uniqueness: { case_sensitive: false }
  validates :name, presence: true
end
