Rails.application.config.middleware.use OmniAuth::Builder do
  provider :login_dot_gov,
  client_id: Rails.configuration.oidc['oidc_sp_issuer'],
  idp_base_url: Rails.configuration.oidc['idp_url'],
  private_key: OpenSSL::PKey::RSA.new(
    Figaro.env.oidc_sp_private_key,
    Figaro.env.oidc_sp_private_key_password
  ),
  redirect_uri: URI.join(
    Rails.configuration.oidc['partners_url'],
    '/auth/logindotgov/callback'
  )
end
