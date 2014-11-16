module OmniAuth
  module Strategies
    class Qiita
      class Client  < ::OAuth2::Client
        def get_token_with_json(params, access_token_opts = {}, access_token_class = AccessToken)
          opts = {:raise_errors => options[:raise_errors], :parse => params.delete(:parse)}
          if options[:token_method] == :post
            headers = params.delete(:headers)
            opts[:body] = params.to_json
            opts[:headers] =  {'Content-Type' => 'application/json'}
            opts[:headers].merge!(headers) if headers
          else
            opts[:params] = params
          end
          response = request(options[:token_method], token_url, opts)
          error = Error.new(response)
          fail(error) if options[:raise_errors] && !(response.parsed.is_a?(Hash) && response.parsed['token'])
          access_token_class.from_hash(self, response.parsed.merge(access_token_opts))
        end

      alias_method :orig_get_token, :get_token
      alias_method :get_token, :get_token_with_json
      end
    end
  end
end
