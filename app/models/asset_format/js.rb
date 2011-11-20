class AssetFormat::Js < AssetFormat
  CONTENT_TYPE = 'text/javascript'
  IMPORT = /[\/\*]{2} *@import[ "'\(]+([^\s"'\);]+)[ "'\)\/\*]*/
  EXTEND_FORMATS = [:coffee]

  def minify text
    Uglifier.compile text, copyright: false
  end

  def coffee text
    CoffeeScript.compile text
  end
end
