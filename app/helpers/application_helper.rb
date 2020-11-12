module ApplicationHelper

    def encode_to_jwt(payload)
        return JWT.encode(payload, ENV['jwt_secret_key'])
    end
    def decode_from_jwt(token)
        return JWT.decode(token, ENV['jwt_secret_key'], true, algorithm: 'HS256')
    end
end
