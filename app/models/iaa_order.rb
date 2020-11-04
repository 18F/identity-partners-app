class IAAOrder < ApplicationRecord
  belongs_to :iaa_gtc, dependent: :destroy

  validates :order_number, presence: true,
                           numericality: { greater_than: 0 },
                           uniqueness: { scope: :iaa_gtc }
  validates :mod_number, presence: true,
                         numericality: { greater_than_or_equal_to: 0 }
  validates :estimated_amount, numericality: { greater_than_or_equal_to: 0,
                                               allow_nil: true }
  validates :billed_amount, numericality: { greater_than_or_equal_to: 0,
                                            allow_nil: true }

  delegate :gtc_number, to: :iaa_gtc

  # Generate the "official" name for the 7600B form, comprised of the GTC
  # number, the order number , and the mod number, both padded to 4 digits and
  # all separated by dashes.
  #
  # @return [String] the official 7600B name
  def name
    "#{gtc_number}-#{name_str(order_number)}-#{name_str(mod_number)}"
  end

  private

  def name_str(val)
    val.to_s.rjust(4, '0')
  end
end
