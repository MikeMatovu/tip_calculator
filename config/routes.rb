Rails.application.routes.draw do
  root "tips#index"
  resources :tips, only: [ :index, :create ]

  namespace :admin do
    get "dashboard/index"
    get "dashboard", to: "dashboard#index", as: :dashboard
  end
end
