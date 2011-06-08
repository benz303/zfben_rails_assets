def sys cmd
  STDOUT.puts cmd.color(:black).background(:white)
  system cmd
end

def err msg
  STDOUT.puts msg.color(:yellow).background(:red)
  exit!
end

namespace :assets do
  desc 'copy assets files to app/assets'
  task :copy_assets do
    js_path = File.join(Rails.root, 'app', 'assets', 'javascripts', 'zff')
    css_path = File.join(Rails.root, 'app', 'assets', 'stylesheets', 'zff')
    img_path = File.join(Rails.root, 'app', 'assets', 'images', 'zff')
    sys('rm -r ' + js_path) if File.exists?(js_path)
    sys('rm -r ' + css_path) if File.exists?(css_path)
    sys('rm -r ' + img_path) if File.exists?(img_path)
    sys 'cp ' << File.join(ZfbenRailsAssetsPath, 'assets') << ' ' << File.join(Rails.root, 'app', 'assets')
  end
end
