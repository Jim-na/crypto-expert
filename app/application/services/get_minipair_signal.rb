# frozen_string_literal: true

require 'dry/transaction'

module CryptoExpert
  module Service
    # TO get tempminipair and compute signal minipair
    class GetMiniPairSignal
      include Dry::Transaction

      step :request_symbol
      step :reify_symbol

      private

      DB_ERR_MSG = 'Could not add tempminipair into database'
      BN_NOT_FOUND_MSG = 'Could not find this pair on Binance'
      SIGNAL_ERR_MSG = 'Could not get the signal of this symbol'
      
      def request_symbol(input)
        result = Gateway::Api.new(CryptoExpert::App.config)
          .get_minipair(input)
        puts result
        result.success? ? Success(result.payload) : Failure(result.message)
      rescue StandardError => e
        puts e.inspect + '\n' + e.backtrace
        Failure('Could not get the signal right now; please try again later')
      end
      
      def reify_symbol(minipair_json)
        Representer::MiniPair.new(OpenStruct.new)
          .from_json(minipair_json)
          .then { |minipair| Success(minipair) }
      rescue StandardError
        Failure('Error in the signal -- please try again')
      end
      
    end
  end
end
