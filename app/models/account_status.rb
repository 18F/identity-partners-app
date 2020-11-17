class AccountStatus < ApplicationRecord
  has_many :accounts, dependent: :nullify

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :order, presence: true, uniqueness: true

  default_scope { order(:order) }
  self.implicit_order_column = :order

  # Override the partner_name getter to fall back to the name attribute if no
  # specific partner name is set
  #
  # @return [String] the partner_name if set, otherwise the name
  def partner_name
    super || name
  end
end
