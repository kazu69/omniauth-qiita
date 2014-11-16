module OmniAuth
  module Strategies
    class Qiita
      class AccessToken < ::OAuth2::AccessToken
        class << self
          def from_hash_with_token(client, hash)
            if hash['token']
              new(client, hash.delete('token') || hash.delete(:token), hash)
            else
              orig_from_hash
            end
          end

          alias_method :orig_from_hash, :from_hash
          alias_method :from_hash, :from_hash_with_token

        end
      end
    end
  end
end
