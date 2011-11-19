class AssetFormat
  def content_type
    self.class::CONTENT_TYPE || 'text/plain'
  end
  
  def text
    if defined?(@path)
      File.read(@path)
    else
      @text || ''
    end
  end
  
  def status
    @status || 200
  end
  
  def log
    status == 200 ? ('read ' + @path) : ('error: ' + @text || '')
  end
  
  private
  
  def not_found path
    @text = 'File not found: ' + path
    @status = 404
  end
  
  def no_error?
    @status.nil? || 200
  end
  
  def initialize file
    @option = file.split('.')
    path = find_file(@option[0] + '.' + @option.last)
    unless path.nil?
      text = File.read(path)
      if defined?(self.class::IMPORT)
        regexp = self.class::IMPORT
        text = import_file regexp, text
      end
      if no_error?
        if self.respond_to?(:complie)
          text = complie(text)
        end
        if @option.include?('min') && self.respond_to?(:minify)
          text = minify(text)
        end
        @path = write_file file, text
      end
    else
      not_found file
    end
  end
  
  def find_file filename
    path = Rails.root.to_s + '/app/assets/' + filename
    if File.exist?(path)
      return path
    else
      list = Dir[path + '.*']
      if list.length > 0
        return list[0]
      else
        return nil
      end
    end
  end
  
  def write_file name, text
    dir = Rails.root.to_s + '/tmp/assets/'
    unless File.exist?(dir)
      FileUtils.mkdir(dir)
    end
    path = dir + File.basename(name)
    File.open(path, 'w'){ |f| f.write text }
    path
  end
  
  def compile_file
    File.read(file)
  end
  
  def import_file regexp, text
    text.gsub(regexp){ |s|
      file = find_file(regexp.match(s)[1])
      unless file.nil?
        "\n/* #{file} */\n" << import_file(regexp, compile_file(file))
      else
        not_found s
        break
      end
    }
  end
end
