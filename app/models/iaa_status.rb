class IAAStatus < ApplicationRecord
  has_many :iaa_gtcs, dependent: :nullify
  has_many :iaa_orders, dependent: :nullify

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :order, presence: true, uniqueness: true

  default_scope { order(:order) }
  self.implicit_order_column = :order
end
