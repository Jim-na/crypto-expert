# frozen_string_literal: true

require_relative '../../../helpers/spec_helper.rb'
describe 'Integration test of get minipair service and API gateway' do
    it 'must get the minipair signal' do
      input = {symbol: MINI_SYMBOL}
      symbol_request = CryptoExpert::Forms::NewSymbol.new.call(input)
      
      # WHEN we request to add a project
      res = CryptoExpert::Service::GetMiniPairSignal.new.call(symbol_request[:symbol])
  
      # THEN we should see a single project in the list
      _(res.success?).must_equal true
      minipair = res.value!
      _(minipair[:symbol]).must_equal MINI_SYMBOL
      _(minipair[:volume_change_percent]).wont_be_nil
      _(minipair[:signal]).wont_be_nil
      _(minipair[:time]).wont_be_nil
      _(minipair[:spot_volume]).wont_be_nil
      _(minipair[:spot_closeprice]).wont_be_nil
      _(minipair[:funding_rate]).wont_be_nil
      _(minipair[:longshort_ratio]).wont_be_nil
      _(minipair[:open_interest]).wont_be_nil
      _(minipair[:spot_change_percent]).wont_be_nil
    end
  end