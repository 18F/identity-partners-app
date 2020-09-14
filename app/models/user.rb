class User < ApplicationRecord
  devise :trackable, :timeoutable

  validates :email, uniqueness: true

  scope :sorted, -> { order(email: :asc) }
end
