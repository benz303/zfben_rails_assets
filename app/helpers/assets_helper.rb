module AssetsHelper
  VER = Time.now.to_i.to_s

  def assets *opts
    return '' if opts.blank?
    html = ''
    opts.each do |name|
      name = name.to_s
      format = File.extname(name)
      if Rails.env.production? && !name.include?('.min.') && (format == '.css' || format == '.js')
        name = name.gsub(format, '.min' << format)
      end
      case format
        when '.css'
          html << assets_css(name)
        when '.js'
          html << assets_js(name)
        else
          path = Rails.root.to_s + '/app/assets/' + name
          css = Dir.glob(([:css] + AssetFormat::Css::EXTEND_FORMATS).map{ |f| path + '.' + f.to_s })
          js = Dir.glob(([:js] + AssetFormat::Js::EXTEND_FORMATS).map{ |f| path + '.' + f.to_s })
          html << assets(name + '.css') if css.length > 0
          html << assets(name + '.js') if js.length > 0
      end
    end
    html
  end
  
  private
  
  def assets_js url
    "<script src=\"#{asset_host}/#{url}\"></script>"
  end

  def assets_css url
    "<link rel=\"stylesheet\" href=\"#{asset_host}/#{url}\" />"
  end
  
  def asset_host
    unless Rails.configuration.action_controller[:asset_host].nil?
      host = Rails.configuration.action_controller[:asset_host].clone
      unless request.nil?
        host << (request.port == 80 ? '' : (':' << request.port.to_s))
      end
    else
      host = ''
    end
    
    unless Rails.configuration.action_controller[:asset_path].nil?
      host << ('/' + Rails.configuration.action_controller[:asset_path])
    else
      host << '/assets'
    end
    
    if Rails.env.production? && Rails.configuration.action_controller[:asset_version].nil?
      Rails.configuration.action_controller[:asset_version] = :now
    end

    unless Rails.configuration.action_controller[:asset_version].nil?
      if Rails.configuration.action_controller[:asset_version] == :now
        host << '/' << VER
      else
        host << '/' << Rails.configuration.action_controller[:asset_version].to_s
      end
    end

    host
  end
end
