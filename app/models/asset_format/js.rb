class AssetFormat::Js < AssetFormat
  CONTENT_TYPE = 'text/javascript'
  IMPORT = /[\/\*]{2}\s*@import[ "'\(]+([^\s"'\);]+)[\s"'\);]*(\*\/)?/
  IMPORT_COFFEE = /# *@import[ "'\(]+([^\s"'\);]+)[ "'\)]*/
  EXTEND_FORMATS = [:coffee]

  def minify text
    ::Uglifier.compile text, copyright: false
  end

  def coffee text
    text = text.gsub(IMPORT_COFFEE){ |s|
      "\n### @import #{IMPORT_COFFEE.match(s)[1]}\n###\n"
    }
    ::CoffeeScript.compile text
  end
end
