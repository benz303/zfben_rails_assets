Rails.application.routes.draw do
  get '/assets/:version/*file' => 'assets#index'
  get '/assets/*file' => 'assets#index'
end
