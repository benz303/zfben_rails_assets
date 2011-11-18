ZfbenRailsAssetsPath = File.join File.dirname(__FILE__), 'zfben_rails_assets'

module ZfbenRailsAssets
  class Railtie < Rails::Railtie
    railtie_name :zfben_rails_assets
      
    rake_tasks do
      load File.join(ZfbenRailsAssetsPath, 'tasks.rb')
    end
    Rails.application.routes.draw do
      get '/test' => 'test'
    end
  end
end
