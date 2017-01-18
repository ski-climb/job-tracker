Rails.application.routes.draw do

  root 'jobs#index'

  resources :contacts, only: [:index, :show, :new, :create]

  resources :companies do
    resources :jobs, except: [:show, :index]
    resources :contacts, only: [:create], to: "company/contacts#create"
  end


  resources :jobs, only: [:show, :index] do
    resources :comments, only: [:create]
  end
  resources :categories

  get '/dashboard' => 'calculations#dashboard', as: 'dashboard'

end
