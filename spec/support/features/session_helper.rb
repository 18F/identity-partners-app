module FeatureSpecHelper
  def sign_in_with_warden(user)
    login_as(user, scope: :user)
  end
end
