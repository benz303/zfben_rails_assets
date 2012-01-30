# encoding: UTF-8
class AssetsController < ActionController::Base
  caches_page :index
  
  def index
    if format_defined?
      render render_assets
    else
      render text: 'Undefined format', status: 500
    end
  end

  private

  def initialize
    # read assets/models to get formats
    @formats = {}
    Dir[File.dirname(__FILE__) << '/../models/asset_format/*.rb', Rails.root.to_s + '/app/assets/asset_format/*.rb'].each do |path|
      @formats[File.basename(path, '.rb')] = path
    end
  end

  def format_defined?
    @formats.has_key?(params[:format])
  end

  def render_assets
    require @formats[params[:format]]
    asset = AssetFormat.const_get(params[:format].capitalize).new("#{params[:file]}.#{params[:format]}")
    { text: asset.text, content_type: asset.content_type, status: asset.status }
  end
end
