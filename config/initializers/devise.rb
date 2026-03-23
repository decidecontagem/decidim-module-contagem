# frozen_string_literal: true

require_relative "../../lib/omniauth/strategies/govbr"

Devise.setup do |config|
  config.omniauth :govbr,
                  ENV.fetch("OMNIAUTH_GOVBR_CLIENT_ID").to_s,
                  ENV.fetch("OMNIAUTH_GOVBR_CLIENT_SECRET").to_s,
                  strategy_class: OmniAuth::Strategies::Govbr,
                  callback_path:  "/users/auth/govbr/callback"
end
