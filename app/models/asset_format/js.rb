class AssetFormat::Js < AssetFormat
  CONTENT_TYPE = 'text/javascript'
  IMPORT = /[\/\*]{2} *@import[ "'\(]+([^\s"'\);]+)[ "'\)\/\*]*/

  def minify text
    Uglifier.compile(text, :copyright => false)
  end
end
