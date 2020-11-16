class IntegrationUsage < ApplicationRecord
  belongs_to :iaa_order
  belongs_to :integration

  validates :auths, presence: true,
                    numericality: { greater_than_or_equal_to: 0 }
end
