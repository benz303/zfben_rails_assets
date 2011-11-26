require 'sass/css'

class AssetFormat::Css < AssetFormat
  CONTENT_TYPE = 'text/css'
  IMPORT = /[\/\* ]*@import[ "'\(]+([^url][^\s"'\);]+)[ "'\);\*\/]*/
  EXTEND_FORMATS = [:sass, :scss]

  def minify text
    ::Sass::Engine.new(::Sass::CSS.new(text).render(:sass), MINIFY_OPTIONS).render
  end

  def sass text
    ::Sass::Engine.new("@import compass\n" << text, SASS_OPTIONS).render
  end

  def scss text
    ::Sass::Engine.new("@import \"compass\";\n" << text, SCSS_OPTIONS).render
  end

  private
  
  COMPASS_OPTIONS = Compass.sass_engine_options.merge({ line_comments: false })
  COMPASS_OPTIONS[:load_paths].push(File.realpath(Rails.root) << '/app/assets')
  MINIFY_OPTIONS = { syntax: :sass, style: :compressed }
  SASS_OPTIONS = { syntax: :sass, style: :expanded }.merge(COMPASS_OPTIONS)
  SCSS_OPTIONS = { syntax: :scss, style: :expanded }.merge(COMPASS_OPTIONS)
end
