require "zfben_rails_assets/version"

module ZfbenRailsAssets
  class Engine < Rails::Engine
  end
  
  class Railtie < Rails::Railtie
    config.before_initialize do
      require 'compass'
      Compass.add_project_configuration File.join(File.dirname(__FILE__), 'zfben_rails_assets', 'config', 'compass.rb')
=begin
      #Rails::Application::Configuration do |conf|
        config.compass.project_type = :rails
        config.compass.project_path = Rails.root
        config.compass.http_path = "/"
        config.compass.css_dir = "public/assets"
        config.compass.sass_dir = "app/assets/stylesheets"
      #end
=end
    end
  end
end
