require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Govbr < OmniAuth::Strategies::OAuth2
      option :name, "govbr"

      option :client_options, {
        site:          "https://sso.acesso.gov.br",
        authorize_url: "/authorize",
        token_url:     "/token"
      }

      option :scope, "openid email profile govbr_confiabilidades"
      option :response_type, "code"

      uid { raw_info["sub"] }

      info do
        {
          name:     raw_info["name"],
          email:    raw_info["email"],
          nickname: raw_info["preferred_username"],
          cpf:      raw_info["cpf"]
        }
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        @raw_info ||= access_token.get(userinfo_url).parsed
      end

      private

      def userinfo_url
        "#{options.client_options.site}/userinfo"
      end

      def pkce_verifier
        @pkce_verifier ||= SecureRandom.hex(32)
      end
    end
  end
end
