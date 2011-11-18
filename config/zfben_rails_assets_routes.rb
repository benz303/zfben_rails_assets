Rails.application.routes.draw do
  mount ZfbenRailsAssets::Engine => "/news"
  get '/test' => 'test#index'
end
