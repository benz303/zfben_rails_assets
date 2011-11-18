ZfbenRailsAssets::Engine.routes.draw do
  get '/assets/:file(.:format)' => 'application#index'
end
