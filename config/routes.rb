unless Rails.configuration.action_controller[:asset_path].nil?
  path = '/' + Rails.configuration.action_controller[:asset_path]
else
  path = '/assets'
end

Rails.application.routes.draw do
  get (path + '/:version/*file') => 'assets#index'
  get (path + '/*file') => 'assets#index'
end
