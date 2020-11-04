class Account < ApplicationRecord
  has_many :iaa_gtcs
  has_many :users
  has_many :apps
  validates :lg_account_id, presence: true,
                            uniqueness: { case_sensitive: false }
  validates :name, presence: true
end
