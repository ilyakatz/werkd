WeRKD::Application.routes.draw do

  devise_for :users,
    path_prefix: "users",
    path: "",
    :controllers => {
      omniauth_callbacks: "users/omniauth_callbacks",
      invitations: 'users/invitations',
    }

  resources :tags, only: [:index]
  match "/contacts/:importer/callback" => "users/omnicontacts#callback"
  namespace :users do
    resources :omnicontacts, only: [ :index, :show]
    resources :dashboards, only: [:index]
    resources :profiles, only: [:index, :update]
    resources :connections, only: [:index] do
      get "accept"
    end
    resources :projects, only: [:new, :create, :update, :edit]
  end
  resources :users, only: [:index, :show]
  resources :projects, only: [:show]

  root :to => 'home#index'

  ActiveAdmin.routes(self)
end
