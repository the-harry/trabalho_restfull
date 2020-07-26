# frozen_string_literal: true

require 'base64'

class Token
  def self.encode(token)
    Base64.encode64(token)
  end

  def self.decode(token)
    Base64.decode64(token)
  end
end
