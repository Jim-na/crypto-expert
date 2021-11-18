# frozen_string_literal: true

require_relative 'minipair'

module Views
  # View for a a list of minipair entities
  class MiniPairList
    def initialize(minipair)
      @minipair = minipair.map.with_index { |pair, i| MiniPair.new(pair, i) }
    end

    def each
      @minipair.each do |pair|
        yield pair
      end
    end

    def any?
      @minipair.any?
    end
  end
end

