require 'sass'

class AssetFormat::Sass < AssetFormat
  CONTENT_TYPE = 'text/css'

  def complie text
    @option.include?('min') ? text : ::Sass::Engine.new(text, { :syntax => :sass, :style => :expanded }).render
  end

  def minify text
    ::Sass::Engine.new(text, { :syntax => :sass, :style => :compressed }).render
  end
end
