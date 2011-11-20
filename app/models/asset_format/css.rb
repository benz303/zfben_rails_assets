require 'sass/css'

class AssetFormat::Css < AssetFormat
  CONTENT_TYPE = 'text/css'
  IMPORT = /[\/\* ]*@import[ "'\(]+([^\s"'\);]+)[ "'\);\*\/]*/
  EXTEND_FORMATS = [:sass, :scss]

  def minify text
    ::Sass::Engine.new(::Sass::CSS.new(text).render(:sass), { syntax: :sass, style: :compressed }).render
  end

  def sass text
    ::Sass::Engine.new(text, { syntax: :sass, style: :expanded }).render
  end

  def scss text
    ::Sass::Engine.new(text, { syntax: :scss, style: :expanded }).render
  end
end
