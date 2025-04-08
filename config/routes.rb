Rails.application.routes.draw do
  authenticate :user do
    mount Blazer::Engine, at: "blazer"
  end

  devise_for :users
  root "tips#index"
  resources :tips

  namespace :admin do
    get "dashboard/index"
    get "dashboard", to: "dashboard#index", as: :dashboard
  end
end
