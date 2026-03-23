# frozen_string_literal: true

module Decidim
  module Govbr
    class OmniauthCallbacksController < ::Decidim::Devise::OmniauthRegistrationsController
      def govbr
        @data = oauth_data

        if user_signed_in?
          authenticator.validate!
          if authenticator.verified_email?
            authenticator.identify_user!
            set_flash_message :notice, :success, kind: "GovBR"
            redirect_to decidim.account_path
          end
        else
          send_magic_link
        end
      rescue Decidim::Socializer::IdentityAlreadyExists
        redirect_to decidim.new_user_session_path,
                    alert: t("decidim.devise.omniauth_callbacks.identity_taken")
      end

      private

      def oauth_data
        {
          provider:  oauth_provider,
          uid:       oauth_uid,
          email:     oauth_email,
          name:      oauth_name,
          nickname:  oauth_nickname,
          avatar_url: nil,
          info:      oauth_info,
          raw_info:  raw_info
        }
      end

      def oauth_provider   = request.env["omniauth.auth"]["provider"]
      def oauth_uid        = request.env["omniauth.auth"]["uid"]
      def oauth_email      = request.env["omniauth.auth"]["info"]["email"]
      def oauth_name       = request.env["omniauth.auth"]["info"]["name"]
      def oauth_nickname   = request.env["omniauth.auth"]["info"]["nickname"]
      def oauth_info       = request.env["omniauth.auth"]["info"]
      def raw_info         = request.env["omniauth.auth"]["extra"]["raw_info"]
    end
  end
end
