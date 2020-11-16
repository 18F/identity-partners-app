class Agency < ApplicationRecord
  has_many :accounts, dependent: :nullify

  validates :abbreviation, presence: true,
                           uniqueness: { case_sensitive: false }
  validates :lg_identifier, presence: true,
                            uniqueness: true,
                            numericality: { greater_than: 0 }
  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }

  default_scope { order(:name) }
end
