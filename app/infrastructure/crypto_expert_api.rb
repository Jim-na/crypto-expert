# frozen_string_literal: true

require_relative 'list_request'
require 'http'
require 'json'

module CryptoExpert
  module Gateway
    # Infrastructure to call CodePraise API
    class Api
      def initialize(config)
        @config = config
        @request = Request.new(@config)
      end

      def alive?
        @request.get_root.success?
      end

      def minipair_list(list)
        @request.minipair_list(list)
      end

      def sortedpair_list
        @request.sortedpair_list
      end

      def get_minipair(symbol)
        @request.get_minipair(symbol)
      end

      # HTTP request transmitter
      class Request
        def initialize(config)
          @api_host = config.API_HOST
          @api_root = "#{config.API_HOST}/api/v1"
        end

        def get_root # rubocop:disable Naming/AccessorMethodName
          call_api('get')
        end

        def minipair_list(list)
          call_api('get', ['minipair'],
                   'list' => Value::WatchedList.to_encoded(list))
        end

        def get_minipair(symbol)
          call_api('post', ['minipair', symbol])
        end

        def sortedpair_list
          call_api('get', ['sortedpair', nil])
        end

        private

        def params_str(params)
          params.map { |key, value| "#{key}=#{value}" }.join('&')
            .then { |str| str ? "?#{str}" : '' }
        end

        def call_api(method, resources = [], params = {})
          api_path = resources.empty? ? @api_host : @api_root
          url = if resources[0] == 'sortedpair'
                  "#{api_path}/#{resources[0]}"
                else
                  [api_path, resources].flatten.join('/') + params_str(params)
                end
          # puts url
          HTTP.headers('Accept' => 'application/json').send(method, url)
            .then { |http_response| Response.new(http_response) }
        rescue StandardError
          raise "Invalid URL request: #{url}"
        end
      end

      # Decorates HTTP responses with success/error
      class Response < SimpleDelegator
        NotFound = Class.new(StandardError)

        SUCCESS_CODES = (200..299)

        def success?
          code.between?(SUCCESS_CODES.first, SUCCESS_CODES.last)
        end

        def message
          JSON.parse(payload)['message']
        end

        def payload
          body.to_s
        end
      end
    end
  end
end
