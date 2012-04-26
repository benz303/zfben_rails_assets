## SUMMARY

A plugin for replace rails pipline.

[![Build Status](https://secure.travis-ci.org/benz303/zfben_rails_assets.png)](http://travis-ci.org/benz303/zfben_rails_assets)

## Getting Started

1. adding gem to Gemfile

  gem 'zfben_rails_assets'

2. update bundle

  bundle install

3. add .gitignore

  public/assets

## How to Use

### Configuration

```ruby
  # config/application.rb
  config.assets.enabled = false
  
  config.action_controller.asset_host = 'http://assets.abc.com'
  config.action_controller.asset_path = 'assets'
  config.action_controller.asset_version = '1'
```

### Helper

```ruby
  assets('blank.css') #=> <link rel="stylesheet" href="/assets/blank.css" />
  assets('blank.js') #=> <script src="/assets/blank.js"></script>
```
