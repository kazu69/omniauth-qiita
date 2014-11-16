require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Qiita < OmniAuth::Strategies::OAuth2
      option :name, 'qiita'

      option :client_options, {
        site: 'https://qiita.com',
        authorize_url: '/api/v2/oauth/authorize',
        token_url: '/api/v2/access_tokens',
      }

      option :authorize_params, {
        scope: 'read_qiita'
      }

      uid { raw_info['id'].to_s }

      info do
        {
          name: raw_info['name'],
          description: raw_info['description'],
          organization: raw_info['organization'],
          location: raw_info['location'],
          website: raw_info['website_url'],
          image: raw_info['profile_image_url'],
          followees_count: raw_info['followees_count'],
          followers_count: raw_info['followers_count'],
          items_count: raw_info['items_count'],
          social: {
            facebook: raw_info['facebook_id'],
            github: raw_info['github_login_name'],
            linkedin_id: raw_info['linkedin_id'],
            twitter: raw_info['twitter_screen_name']
          }
        }
      end

      extra do
        skip_info? ? {} : { :raw_info => raw_info }
      end

      def raw_info
        @raw_info = @raw_info || access_token.get('/api/v2/authenticated_user').parsed
      end

      def client
        OmniAuth::Strategies::Qiita::Client.new(options.client_id, options.client_secret, deep_symbolize(options.client_options))
      end

    end
  end
end

OmniAuth.config.add_camelization 'qiita', 'Qiita'
