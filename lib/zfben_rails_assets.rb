
module ZfbenRailsAssets
  mattr_accessor :app_root

  def self.setup
    yield self
  end

  class Engine < Rails::Engine
    engine_name :zfben_rails_assets
    isolate_namespace ZfbenRailsAssets
  end
end
