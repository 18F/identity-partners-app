class Account < ApplicationRecord
  has_many :users
  has_many :apps
  validates :lg_account_id, presence: true, uniqueness: true
  validates :name, presence: true
end
