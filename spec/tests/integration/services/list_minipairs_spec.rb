# frozen_string_literal: true

require_relative '../../../helpers/spec_helper'

describe 'Integration test of list minipair service and API gateway' do
  it 'must see minipair' do
    # WHEN we request to list a miniparis

    list = [MINI_SYMBOL]
    res = CryptoExpert::Service::ListMiniPairs.new.call(list)

    # THEN we should see a single minipair in the list
    _(res.success?).must_equal true
    minipairs = res.value!.minipairs
    _(minipairs[0]['symbol']).must_equal MINI_SYMBOL
    _(minipairs[0]['volume_change_percent']).wont_be_nil
    _(minipairs[0]['signal']).wont_be_nil
    _(minipairs[0]['time']).wont_be_nil
    _(minipairs[0]['spot_volume']).wont_be_nil
    _(minipairs[0]['spot_closeprice']).wont_be_nil
    _(minipairs[0]['funding_rate']).wont_be_nil
    _(minipairs[0]['longshort_ratio']).wont_be_nil
    _(minipairs[0]['open_interest']).wont_be_nil
    _(minipairs[0]['spot_change_percent']).wont_be_nil
  end

  it 'must cant see minipair' do
    # WHEN we request to list a miniparis

    list = []
    res = CryptoExpert::Service::ListMiniPairs.new.call(list)

    # THEN we should see a single minipair in the list
    _(res.success?).must_equal true
    minipairs = res.value!.minipairs
    _(minipairs).must_equal []
  end
end
