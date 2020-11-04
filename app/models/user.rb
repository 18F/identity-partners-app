class User < ApplicationRecord
  devise :trackable, :timeoutable

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :uuid, uniqueness: { case_sensitive: false }, allow_nil: true

  scope :sorted, -> { order(email: :asc) }
end
