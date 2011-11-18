class ActionController::Routing::RouteSet
  def load_routes_with_clearance!
    clearance_routes = File.join(File.dirname(__FILE__), 
                       *%w[.. config zfben_rails_assets_routes.rb])
    unless configuration_files.include? clearance_routes
      add_configuration_file(clearance_routes)
    end
    load_routes_without_clearance!
  end

  alias_method_chain :load_routes!, :clearance
end

module ZfbenRailsAssets
  class Engine < Rails::Engine
    engine_name :zfben_rails_assets
    isolate_namespace ZfbenRailsAssets
  end
end
