# frozen_string_literal: true

require_relative 'spec_helper'
require_relative 'helpers/vcr_helper'
describe 'Tests Binance API library' do
  VcrHelper.setup_vcr
  before do
    VcrHelper.configure_vcr_for_bn
  end

  after do
    VcrHelper.eject_vcr
  end

  describe 'Major Pair get information' do
    before do
      @majorpair = CryptoExpert::Binance::MajorPairMapper.new(BINANCE_API_KEY).get(MAJOR_SYMBOL)
    end
    it 'HAPPY: should get Major CurrencyPair' do
      _(@majorpair).must_be_kind_of CryptoExpert::Entity::MajorPair
    end
    it 'HAPPY: should get Major CurrencyPair symbol' do
      _(@majorpair.symbol).wont_be_nil
      _(@majorpair.symbol).must_equal MAJOR_SYMBOL
    end
    it 'HAPPY: should get Major CurrencyPair spot volume' do
      _(@majorpair.spot_volume).wont_be_nil
    end
    it 'HAPPY: should get Major CurrencyPair future volume' do
      _(@majorpair.future_volume).wont_be_nil
    end
    it 'HAPPY: should get Major CurrencyPair funding rate' do
      _(@majorpair.funding_rate).wont_be_nil
    end
    it 'HAPPY: should get Major CurrencyPair open interest' do
      _(@majorpair.open_interest).wont_be_nil
    end
    it 'HAPPY: should get Major CurrencyPair longshort ratio' do
      _(@majorpair.longshort_ratio).wont_be_nil
    end
    it 'SAD: should raise exception on notfound currency pair' do
      _(proc do
        CryptoExpert::Binance::MajorPairMapper.new(BINANCE_API_KEY).get('TINAJIMBO')
      end).must_raise CryptoExpert::HttpApi::Response::BadRequest
    end
  end

  describe 'Mini Pair get information' do
    before do
      @minipair = CryptoExpert::Binance::MiniPairMapper.new(BINANCE_API_KEY).get(MINI_SYMBOL)
    end
    it 'HAPPY: should get Mini CurrencyPair' do
      _(@minipair).must_be_kind_of CryptoExpert::Entity::MiniPair
    end
    it 'HAPPY: should get Mini CurrencyPair symbol' do
      _(@minipair.symbol).wont_be_nil
      _(@minipair.symbol).must_equal MINI_SYMBOL
    end
    it 'HAPPY: should get Mini CurrencyPair time' do
      _(@minipair.time).wont_be_nil
    end
    it 'HAPPY: should get Mini CurrencyPair volume' do
      _(@minipair.volume).wont_be_nil
    end
    it 'SAD: should raise exception on notfound currency pair' do
      _(proc do
        CryptoExpert::Binance::MiniPairMapper.new(BINANCE_API_KEY).get('TINAJIMBO')
      end).must_raise CryptoExpert::HttpApi::Response::BadRequest
    end
  end
end
