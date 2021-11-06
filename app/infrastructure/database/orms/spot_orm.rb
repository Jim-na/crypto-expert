# frozen_string_literal: true

require 'sequel'

module CryptoExpert
  module Database
    # Object-Relational Mapper for Members
    class SpotOrm < Sequel::Model(:spots)
      one_to_many :records,
                  class: :'CryptoExpert::Database::RecordOrm',
                  key: :records

      plugin :timestamps, update_on_create: true

      def self.find_or_create(symbol_name)
        first(symbol: symbol_name[:symbol]) || create(symbol_name)
      end
    end
  end
end