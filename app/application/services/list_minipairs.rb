# frozen_string_literal: true

require 'dry/monads'

module CryptoExpert
  module Service
    # Retrieves array of all listed minipair signal entities
    class ListMiniPairs
      include Dry::Transaction

      step :get_api_list
      step :reify_list
      # step :view_minipair

      private

      NO_PAIR_ERR = 'Add a Mini Pair to get started'
      VIEW_PAIR_ERR = 'Can not make viewable pairs'
      
      def get_api_list(minipair_list)
        Gateway::Api.new(CryptoExpert::App.config)
          .minipair_list(minipair_list)
          .then do |result|
            result.success? ? Success(result.payload) : Failure(result.message)
          end
      rescue StandardError
        Failure('Could not access our API')
      end

      def reify_list(minipair_json)
        Representer::MiniPairList.new(OpenStruct.new)
          .from_json(minipair_json)
          .then { |minipairs| Success(minipairs) }
      rescue StandardError
        Failure('Could not parse response from API')
      end

      # def view_minipair(input)
      #   viewable_minipairs = Views::MiniPairList.new(input)
      #   Success(viewable_minipairs)
      # rescue StandardError => e
      #   puts e.backtrace.join("\n")
      #   Failure(VIEW_PAIR_ERR)
      # end
      
    end
  end
end
