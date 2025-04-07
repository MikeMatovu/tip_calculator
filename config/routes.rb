Rails.application.routes.draw do
  mount Blazer::Engine, at: "blazer"
  root "tips#index"
  resources :tips

  namespace :admin do
    get "dashboard/index"
    get "dashboard", to: "dashboard#index", as: :dashboard
  end
end
