Rails.application.routes.draw do
  get 'photos/index'
  devise_for :users
  get 'home/index'
  get 'home/show'
  root "home#index"
  resources :albums do
    collection do
      delete "purge"
    end
  end

  delete "images/:id/purge", to: "albums#purge", as: "purge_image"
  resources :home


end
