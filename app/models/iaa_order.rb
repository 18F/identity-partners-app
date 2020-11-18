class IAAOrder < ApplicationRecord
  belongs_to :iaa_gtc
  belongs_to :iaa_status, optional: true

  has_many :integration_usages, dependent: :destroy

  validates :order_number, presence: true,
                           numericality: { greater_than: 0 },
                           uniqueness: { scope: :iaa_gtc }
  validates :mod_number, presence: true,
                         numericality: { greater_than_or_equal_to: 0 }
  validates :estimated_amount, presence: true,
                               numericality: { greater_than_or_equal_to: 0 }
  validates :platform_fee, presence: true,
                           numericality: { greater_than_or_equal_to: 0 }
  validates :ial2_users, presence: true,
                         numericality: { greater_than_or_equal_to: 0 }

  delegate :gtc_number, to: :iaa_gtc

  # Generate the "official" name for the 7600B form, comprised of the GTC
  # number, the order number , and the mod number, both padded to 4 digits and
  # all separated by dashes.
  #
  # @return [String] the official 7600B name
  def name
    "#{gtc_number}-#{name_str(order_number)}-#{name_str(mod_number)}"
  end

  # Returns the estimated amount obligated based on the platform fee and entered
  # usage across the associated integrations. Pricing parameters are managed in
  # the environment
  def cost_to_date
    total_auths = integration_usages.pluck(:auths).sum
    auth_cost = total_auths * Figaro.env.per_auth_cost.to_f
    ial2_user_cost = ial2_users * Figaro.env.per_ial2_user_cost.to_f

    platform_fee + auth_cost + ial2_user_cost
  end

  private

  def name_str(val)
    val.to_s.rjust(4, '0')
  end
end
