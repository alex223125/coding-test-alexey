Rails.application.routes.draw do
  resources :segments
  resources :findings
  resources :reports

  require 'sidekiq/web'
  Rails.application.routes.draw do
    mount Sidekiq::Web => '/sidekiq'
  end
end
