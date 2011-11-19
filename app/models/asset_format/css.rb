require 'sass/css'

class AssetFormat::Css < AssetFormat
  CONTENT_TYPE = 'text/css'
  IMPORT = /[\/\* ]*@import[ "'\(]+([^\s"'\);]+)[ "'\);\*\/]*/

  def minify text
    ::Sass::Engine.new(::Sass::CSS.new(text).render(:sass), { :syntax => :sass, :style => :compressed }).render
  end
end
