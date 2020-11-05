class IntegrationContact < ApplicationRecord
  belongs_to :integration
  belongs_to :user

  validates :integration, presence: true
  validates :user, presence: true, uniqueness: { scope: :integration }
end
