class User < ActiveRecord::Base
  before_create :set_auth_token

  def self.authenticate(username, password)
    find_by(username: username, password:password)
  end

  def self.authenticate_with_token(token)
    find_by(auth_token: token)
  end

  private

  def set_auth_token
    return if auth_token.present?
    self.auth_token = generate_auth_token
  end

  def generate_auth_token
    # Keep looping until a unique token is generated

    loop do
      token = SecureRandom.hex
      break token unless self.class.exists?(auth_token: token)
    end
  end
end
