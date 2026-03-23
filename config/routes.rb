Rails.application.routes.draw do
  devise_scope :user do
    get  "/users/auth/govbr",          to: "decidim/govbr/omniauth_callbacks#passthru"
    get  "/users/auth/govbr/callback", to: "decidim/govbr/omniauth_callbacks#govbr"
    post "/users/auth/govbr/callback", to: "decidim/govbr/omniauth_callbacks#govbr"
  end
end
