require 'omniauth-oauth'
require 'multi_json'

module OmniAuth
  module Strategies
    class Stockspace < OmniAuth::Strategies::OAuth
      option :name, 'stockspace'

      option :client_options, {
        :site => 'http://localhost:3001',
        :authorize_path => '/oauth/authorize',
        :access_token_path => '/oauth/token'
      }

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
