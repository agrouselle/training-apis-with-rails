def json(body)
  JSON.parse(body, symbolize_names: true)
end

def encode_credentials(username, password)
  ActionController::HttpAuthentication::Basic.encode_credentials(username, password)
end

def token_header(token)
  ActionController::HttpAuthentication::Token.encode_credentials(token)
end