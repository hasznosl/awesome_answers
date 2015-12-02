Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # the routes file is basically a set of routes
  # it is not aware of controllers' existence

  # root "welcome#index"
  root "questions#index"

  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]

  resources :users, only: [:new, :create]

  get "/index" => "welcome#index"
  get "/hello" => "welcome#hello"
  # when using a symbol like string within a url, it means it is a variable
  # part of the url, this is what's called a dynamic url
  get "/greeting/:name" => "welcome#greeting", as: :greeting
  get "/home" => "welcome#index"
  #

  resources :sessions, only: [:new, :create] do
    # in this case we dont need an id
    delete :destroy, on: :collection
  end

  resources :questions do
    resources :likes, only: [:create, :destroy]
    resources :votes, only: [:create, :destroy, :update]
    resources :favourites, only: [:create, :destroy]
    resources :answers
  end

end
