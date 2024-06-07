Rails.application.routes.draw do
  get 'javascripts/show'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  namespace :openai do
    get 'tests/', to: 'tests#generate_text'
    get 'tests/show', to: 'tests#show'
  end

  namespace :fhir do
    resources :patients, only: [:index, :new, :create]
    resources :organizations, only: [:index]
    resources :encounters, only: [:index]
  end

  # Google_Healthcare_API
  get 'healthcare/index', to: 'healthcare#index'
  post 'healthcare/create_patient', to: 'healthcare#create_patient'


  get 'postcode/', to: 'post_codes#show'
end
