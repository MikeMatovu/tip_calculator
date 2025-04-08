Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    mount Blazer::Engine, at: "blazer"
  end

  root "tips#index"
  resources :tips

  namespace :admin do
    get "dashboard/index"
    get "dashboard", to: "dashboard#index", as: :dashboard
  end
end
