# frozen_string_literal: true

module Views
  # View for a single project entity
  class MiniPair
    def initialize(minipair, index = nil)
      @minipair = minipair
      @index = index
    end

    def entity
      @minipair
    end

    def praise_link
      "/minipair/#{symbol}"
    end

    def index_str
      "minipair[#{@index}]"
    end

    def symbol
      @minipair.symbol
    end

    def volume_change_percent
      @minipair.volume_change_percent
    end
    
    def signal
      @minipair.signal
    end
    
    def time
      @minipair.time
    end
    
    def spot_volume
      @minipair.spot_volume
    end
    
    def spot_closeprice
      @minipair.spot_closeprice
    end
    
    def funding_rate
      @minipair.funding_rate
    end
    
    def longshort_ratio
      @minipair.longshort_ratio
    end
    
    def open_interest
      @minipair.open_interest
    end
    
    def spot_change_percent
      @minipair.spot_change_percent
    end
    
  end
end
