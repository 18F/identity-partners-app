class Account < ApplicationRecord
  has_many :iaa_gtcs
  has_many :iaa_orders, through: :iaa_gtcs
  has_many :integrations
  has_many :users

  validates :lg_account_id, presence: true,
                            uniqueness: { case_sensitive: false }
  validates :name, presence: true
end
