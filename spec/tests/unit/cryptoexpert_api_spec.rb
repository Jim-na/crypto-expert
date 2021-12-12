# frozen_string_literal: true

require_relative '../../helpers/spec_helper.rb'

describe 'Unit test of CryptoExpert API gateway' do
  it 'must report alive status' do
    alive = CryptoExpert::Gateway::Api.new(CryptoExpert::App.config).alive?
    _(alive).must_equal true
  end

  it 'must be able to get minipair' do
    res = CryptoExpert::Gateway::Api.new(CryptoExpert::App.config).get_minipair(MINI_SYMBOL)

    _(res.success?).must_equal true
    minipair = res.parse

    _(minipair['symbol']).must_equal MINI_SYMBOL
    _(minipair['volume_change_percent']).wont_be_nil
    _(minipair['signal']).wont_be_nil
    _(minipair['time']).wont_be_nil
    _(minipair['spot_volume']).wont_be_nil
    _(minipair['spot_closeprice']).wont_be_nil
    _(minipair['funding_rate']).wont_be_nil
    _(minipair['longshort_ratio']).wont_be_nil
    _(minipair['open_interest']).wont_be_nil
    _(minipair['spot_change_percent']).wont_be_nil
  end

  it 'must be able to list minipair' do
    list = [MINI_SYMBOL]
    res = CryptoExpert::Gateway::Api.new(CryptoExpert::App.config).minipair_list(list)

    _(res.success?).must_equal true
    minipair = res.parse['minipairs'][0]

    _(minipair['symbol']).must_equal MINI_SYMBOL
    _(minipair['volume_change_percent']).wont_be_nil
    _(minipair['signal']).wont_be_nil
    _(minipair['time']).wont_be_nil
    _(minipair['spot_volume']).wont_be_nil
    _(minipair['spot_closeprice']).wont_be_nil
    _(minipair['funding_rate']).wont_be_nil
    _(minipair['longshort_ratio']).wont_be_nil
    _(minipair['open_interest']).wont_be_nil
    _(minipair['spot_change_percent']).wont_be_nil
  end

#   it 'must return a list of projects' do
#     # GIVEN a project is in the database
#     CodePraise::Gateway::Api.new(CodePraise::App.config)
#       .add_project(USERNAME, PROJECT_NAME)

#     # WHEN we request a list of projects
#     list = [[USERNAME, PROJECT_NAME].join('/')]
#     res = CodePraise::Gateway::Api.new(CodePraise::App.config)
#       .projects_list(list)

#     # THEN we should see a single project in the list
#     _(res.success?).must_equal true
#     data = res.parse
#     _(data.keys).must_include 'projects'
#     _(data['projects'].count).must_equal 1
#     _(data['projects'].first.keys.count).must_be :>=, 5
#   end

#   it 'must return a project appraisal' do
#     # GIVEN a project is in the database
#     CodePraise::Gateway::Api.new(CodePraise::App.config)
#       .add_project(USERNAME, PROJECT_NAME)

#     # WHEN we request an appraisal
#     req = OpenStruct.new(
#       project_fullname: USERNAME + '/' + PROJECT_NAME,
#       owner_name: USERNAME,
#       project_name: PROJECT_NAME,
#       foldername: ''
#     )

#     res = CodePraise::Gateway::Api.new(CodePraise::App.config)
#       .appraise(req)

#     # THEN we should see a single project in the list
#     _(res.success?).must_equal true
#     data = res.parse
#     _(data.keys).must_include 'project'
#     _(data.keys).must_include 'folder'
#   end

end