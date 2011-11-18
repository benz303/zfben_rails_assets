Rails.application.routes.draw do
  mount ZfbenRailsAssets::Engine => '/'
end

ZfbenRailsAssets::Engine.routes.draw do
  get '/assets/:file(.:format)' => 'assets#index'
end
