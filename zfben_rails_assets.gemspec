# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'zfben_rails_assets'
  s.version     = '0.0.16'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Ben']
  s.email       = ['ben@zfben.com']
  s.homepage    = 'https://github.com/benz303/zfben_rails_assets'
  s.summary     = %q{}
  s.description = %q{}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
  
  s.required_ruby_version     = '>= 1.9'
  
  s.add_dependency 'rails', '>=3.1.0'
  s.add_dependency 'sass'
  s.add_dependency 'compass'
  s.add_dependency 'coffee-script'
  s.add_dependency 'uglifier'
  s.add_dependency 'haml'
end
