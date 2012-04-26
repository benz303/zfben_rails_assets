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
    @format = @option.last
    path = find_file(@option[0] + '.' + @option.last)
    unless path.nil?
      text = read_file(path)
      if defined?(self.class::IMPORT)
        regexp = self.class::IMPORT
        text = import_file(regexp, text)
      end
      if no_error?
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
      path = path.gsub('.' + @format, '')
      formats = [@format]
      if defined?(self.class::EXTEND_FORMATS)
        formats = formats + self.class::EXTEND_FORMATS
      end
      list = Dir.glob(formats.map{ |f| path + '.' + f.to_s })
      if list.length > 0
        return list[0]
      else
        return nil
      end
    end
  end

  def read_file file
    text = File.read file
    format = File.extname(file).gsub('.', '').to_sym
    if self.respond_to?(format)
      text = self.method(format).call(text)
    end
    text
  end
  
  def write_file name, text
    dir = Rails.root.to_s + '/tmp/assets/'
    unless File.exist?(dir)
      FileUtils.mkdir_p(dir)
    end
    path = dir + File.basename(name)
    File.open(path, 'w'){ |f| f.write text }
    path
  end
  
  def import_file regexp, text
    text.gsub(regexp){ |s|
      file = find_file(regexp.match(s).to_a.last)
      unless file.nil?
        "\n/* #{file} */\n" << import_file(regexp, read_file(file))
      else
        not_found s
        break
      end
    }
  end
end
