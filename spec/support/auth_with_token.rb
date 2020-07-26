# frozen_string_literal: true

module AuthWithToken
  def authenticate_with_token(token)
    ActionController::HttpAuthentication::Token.encode_credentials(token)
  end
end
