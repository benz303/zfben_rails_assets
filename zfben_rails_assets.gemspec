# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "zfben_rails_assets/version"

Gem::Specification.new do |s|
  s.name        = "zfben_rails_assets"
  s.version     = ZfbenRailsAssets::VERSION
  s.authors     = ["Ben"]
  s.email       = ["ben@zfben.com"]
  s.homepage    = "https://github.com/benz303/zfben_rails_assets"
  s.summary     = %q{}
  s.description = %q{}

  s.rubyforge_project = "zfben_rails_assets"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency  'rails', '>= 3.1'
  
  # html
  s.add_dependency  'haml'
  s.add_dependency  'haml-coderay'
  s.add_dependency  'coderay_bash'
  
  # css
  s.add_dependency  'compass'
  
  # javascript
  s.add_dependency  'therubyracer'
  s.add_dependency  'coffee-script'
  s.add_dependency  'uglifier'
  
  # external
  s.add_dependency  'zff'
end
