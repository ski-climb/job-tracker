Rails.application.routes.draw do

  resources :companies do
    resources :jobs, except: [:show]
  end

  resources :jobs, only: [:show] do
    resources :comments, only: [:create]
  end
  resources :categories
end
