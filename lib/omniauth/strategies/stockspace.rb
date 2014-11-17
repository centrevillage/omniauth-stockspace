require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Stockspace < OmniAuth::Strategies::OAuth2
      option :name, 'stockspace'

      option :client_options, {
        :site => 'http://localhost:3001',
        :authorize_url => 'https://localhost:3001/oauth/authorize',
        :token_url => 'http://localhost:3001/oauth/token'
      }

      def request_phase
        options[:scope] ||= 'basic'
        options[:response_type] ||= 'code'
        super
      end

      uid { raw_info['_id'] }

      info do
        {
          :name   => raw_info['name'],
          :nickname => raw_info['disp_name'],
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v1/me.json').parsed
      end

    end
  end
end
