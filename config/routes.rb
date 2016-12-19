Rails.application.routes.draw do

  root 'jobs#index'

  resources :companies do
    resources :jobs, except: [:show, :index]
    resources :contacts, only: [:create]
  end

  resources :jobs, only: [:show, :index] do
    resources :comments, only: [:create]
  end
  resources :categories
end
