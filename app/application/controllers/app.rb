# frozen_string_literal: true

require 'roda'
require 'slim'
require 'slim/include'

module CryptoExpert
  # Web App
  class App < Roda
    plugin :halt
    plugin :flash
    plugin :all_verbs # recognizes HTTP verbs beyond GET/POST (e.g., DELETE)
    plugin :render, engine: 'slim', views: 'app/presentation/view_html'
    # plugin :public, root: 'app/presentation/public'
    plugin :assets, path: 'app/presentation/assets',
                    css: 'style.css', js: 'table_sort.js'

    use Rack::MethodOverride # for other HTTP verbs (with plugin all_verbs)

    route do |routing|
      routing.assets # load CSS and js

      routing.root do
        session[:watching] ||= []
        # puts pairlist
        view 'home'
      end
      routing.on 'kol' do
        view 'home'
      end

      routing.on 'minipair' do
        routing.is do
          # POST /project/
          routing.post do
            input = {symbol: routing.params['symbol'].upcase}
            symbol_request = Forms::NewSymbol.new.call(input)
            puts "req ",symbol_request[:symbol]
            minipair_made = Service::GetMiniPairSignal.new.call(symbol_request[:symbol])
            if minipair_made.failure?
              puts "hi"
              flash[:error] = minipair_made.failure
              routing.redirect '/'
            end
            minipair = minipair_made.value!
            # Still got bug when under "/minipair" to search another pair??
            session[:watching].insert(0, minipair.symbol).uniq!
            puts session[:watching]
            routing.redirect "minipair/#{symbol_request[:symbol]}"
          end
          routing.get do
            puts session[:watching]
            result = Service::ListMiniPairs.new.call(session[:watching])
            
            # if viewable_minipairs_made.failure?
            #   flash[:error] = viewable_minipairs_made.failure
            #   routing.redirect '/'
            # end
            
            if result.failure?
              flash[:error] = result.failure
              viewable_minipairs = []
            else
              minipairs = result.value!.minipairs
              if minipairs.none?
                flash.now[:notice] = 'Add a Github project to get started'
              end
    
              session[:watching] = minipairs.map(&:fullname)
              viewable_minipairs = Views::MiniPairList.new(minipairs)
            end
            
            # viewable_minipairs = viewable_minipairs_made.value!
            view 'minipair_index', locals: { pairlist: viewable_minipairs }
          end
        end

        routing.on String do |symbol|
          # GET /minipair/{symbol}
          routing.get do
            minipair_made = Service::GetMiniPairSignal.new.call(symbol)
            puts minipair_made.value!
            minipair = Views::MiniPair.new(minipair_made.value!)
            puts minipair
            view 'minipair', locals: { pair: minipair }
          end
        end
        
      end
    end
  end
end
