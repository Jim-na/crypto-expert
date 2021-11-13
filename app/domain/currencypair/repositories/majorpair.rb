# frozen_string_literal: true

module CryptoExpert
  module Repository
    # Repository for MajorPair
    class MajorPair
      def self.all
        Database::MajorPairOrm.all.map { |majorpair| rebuild_entity(majorpair) }
      end

      def self.find_symbol(symbol)
        rebuild_entity Database::MajorPairOrm.first(symbol: symbol)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::MajorPairOrm.new(
          symbol: db_record.symbol,
          volume: db_record.volume,
          funding_rate: db_record.funding_rate,
          open_interest: db_record.open_interest,
          future_volume: db_record.future_volume,
          time: db_record.time
        )
      end
    end
  end
end