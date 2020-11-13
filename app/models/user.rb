class User < ApplicationRecord
  devise :trackable, :timeoutable

  has_many :account_contacts, dependent: :destroy
  has_many :accounts, through: :account_contacts
  has_many :integration_contacts, dependent: :destroy
  has_many :integrations, through: :integration_contacts

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :uuid, uniqueness: { case_sensitive: false }, allow_nil: true

  scope :sorted, -> { order(email: :asc) }
end
