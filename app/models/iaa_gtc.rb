class IAAGTC < ApplicationRecord
  belongs_to :account

  has_many :iaa_orders, dependent: :destroy

  validates :gtc_number, presence: true,
                         uniqueness: { case_sensitive: false }
  validates :mod_number, presence: true,
                         numericality: { greater_than_or_equal_to: 0 }
  validates :estimated_amount, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  # Generate the "official" name for the 7600A form, comprised of the GTC
  # number, an order number of 0, and the mod number, both padded to 4 digits
  # and all separated by dashes.
  #
  # @return [String] the official 7600A name
  def name
    "#{gtc_number}-0000-#{mod_number.to_s.rjust(4, '0')}"
  end
end
