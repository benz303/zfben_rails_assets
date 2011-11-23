require 'sass'
require 'compass'
require 'coffee-script'
require 'uglifier'

module ZfbenRailsAssets
  class Engine < Rails::Engine
    engine_name :zfben_rails_assets
    isolate_namespace ZfbenRailsAssets
    initializer 'zfben_rails_assets.helper' do |app|
      ActionView::Base.send :include, AssetsHelper
    end
  end
end
