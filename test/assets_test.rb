require 'test_helper'

class ModuleTest < ActiveSupport::TestCase
  test 'ModuleTest' do
    assert_kind_of Module, ZfbenRailsAssets
  end
end

class CssTest < ActiveSupport::TestCase
  ["@import file\n", '@import(file)', '@import("file")', '@import "file"', '@import file;', '/* @import file */'].each do |test|
    test('import regex: ' + test)do
      assert_equal AssetFormat::Css::IMPORT.match(test)[1], 'file', AssetFormat::Css::IMPORT.match(test)
    end
  end
end

class JsTest < ActiveSupport::TestCase
  ["// @import file\n", '//@import(file)', '//@import("file")', '//@import "file"', '//@import file;', '/* @import file */', "// aaa\n/*\n @import file\n*/"].each do |test|
    test('import regex: ' + test)do
      assert_equal AssetFormat::Js::IMPORT.match(test)[1], 'file', AssetFormat::Js::IMPORT.match(test)
    end
  end
end

class RoutesTest < ActionController::TestCase
  test '/assets/file.format' do
    assert_routing '/assets/file.format', { controller: 'assets', action: 'index', file: 'file', format: 'format' }
  end
  
  test '/assets/version/file.format' do
    assert_routing '/assets/version/file.format', { controller: 'assets', action: 'index', file: 'file', format: 'format', version: 'version' }
  end
  
  test '/assets/file.option.format' do
    assert_routing '/assets/file.option.format', { controller: 'assets', action: 'index', file: 'file.option', format: 'format' }
  end
  
  test '/assets/version/file.option.format' do
    assert_routing '/assets/version/file.option.format', { controller: 'assets', action: 'index', file: 'file.option', format: 'format', version: 'version' }
  end
end

class ControllerTest < ActionController::TestCase
  setup do
    @controller = AssetsController.new
  end

  test 'undefined format' do
    get :index, file: 'file', format: 'undefined'
    assert_response 500
  end

  test 'not found file' do
    get :index, file: 'notfound', format: 'css'
    assert_response 404
  end

  ['css', 'js'].each do |format|
    test('blank.' + format)do
      get :index, file: 'blank', format: format
      assert_response :success
      assert_equal @response.body, File.read(Rails.root.to_s + '/app/assets/blank.' + format)
    end

    test('import.' + format)do
      get :index, file: 'import', format: format
      assert_response :success
      assert @response.body.include?(File.read(Rails.root.to_s + '/app/assets/blank.' + format))
    end
    
    test('import_twice.' + format)do
      get :index, file: 'import_twice', format: format
      assert_response :success
      count = 0
      @response.body.gsub(File.read(Rails.root.to_s + '/app/assets/blank.' + format)){ count = count + 1 }
      assert count == 2
    end
    
    test('import_iteration.' + format)do
      get :index, file: 'import_iteration', format: format
      assert_response :success
      count = 0
      @response.body.gsub(File.read(Rails.root.to_s + '/app/assets/blank.' + format)){ count = count + 1 }
      assert count == 2
    end
    
    test('import_iteration.min.' + format)do
      get :index, file: 'import_iteration.min', format: format
      assert_response :success
      assert_equal @response.body, ''
    end
    
    test('import_404.' + format)do
      get :index, file: 'import_404', format: format
      assert_response 404
    end
  end
  
  test 'sass.css' do
    get :index, file: 'sass', format: 'css'
    assert_response :success
    assert_equal @response.body, ::Sass::Engine.new(File.read(Rails.root.to_s + '/app/assets/sass.sass'), { syntax: :sass, style: :expanded }).render
  end

  test 'scss.css' do
    get :index, file: 'scss', format: 'css'
    assert_response :success
    assert_equal @response.body, ::Sass::Engine.new(File.read(Rails.root.to_s + '/app/assets/scss.scss'), { syntax: :scss, style: :expanded }).render
  end

  test 'coffee.js' do
    get :index, file: 'coffee', format: 'js'
    assert_response :success
    assert_equal @response.body, CoffeeScript.compile(File.read(Rails.root.to_s + '/app/assets/coffee.coffee'))
  end
end

class AssetsHelperTest < ActionView::TestCase
  setup do
    Rails.env = 'test'
    Rails.configuration.action_controller[:asset_host] = nil
    Rails.configuration.action_controller[:asset_path] = nil
    Rails.configuration.action_controller[:asset_version] = nil
  end

  test 'assets blank.css' do
    assert_equal assets('blank.css'), '<link rel="stylesheet" href="/assets/blank.css" />'
  end

  test 'assets blank.js' do
    assert_equal assets('blank.js'), '<script src="/assets/blank.js"></script>'
  end

  test 'assets blank' do
    assert_equal assets('blank'), assets('blank.css') << assets('blank.js')
  end

  test 'assets in production' do
    Rails.env = 'production'
    Rails.configuration.action_controller[:asset_host] = 'http://assets.com'
    Rails.configuration.action_controller[:asset_path] = 'assets_path'
    Rails.configuration.action_controller[:asset_version] = 'version'
    assert_equal assets('blank.css'), '<link rel="stylesheet" href="http://assets.com/assets_path/version/blank.min.css" />'
    assert_equal assets('blank.js'), '<script src="http://assets.com/assets_path/version/blank.min.js"></script>'
    assert_equal assets('blank'), assets('blank.css') << assets('blank.js')
  end
end
