class IAA < ApplicationRecord
  belongs_to :account, dependent: :destroy

  validates :number, presence: true,
                     uniqueness: { case_sensitive: false }
  validates :estimated_amount, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :billed_amount, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
end
