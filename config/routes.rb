Rails.application.routes.draw do
  resources :shots do
    resources :comments
    member do
      put 'like', to: "shots#like"
      put 'unlike', to: "shots#unlike"
    end
  end
  devise_for :users , controllers: {registrations: 'registrations'}
  root 'shots#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/my_shots" , to: "shots#my_shots" , as: "my_shots"
  resources :profile
  get "/all_users" , to: "home#all_users" , as: "all_users"
  get "/follow_request" , to: "home#follow_request" , as: "follow_request"
  get "/current_profile" , to: "home#current_profile" , as: "current_profile"

  post "/profile/:id/follow" , to: "profile#follow" , as: "follow"
  post "/profile/:id/unfollow" , to: "profile#unfollow" , as: "unfollow"
  post "/profile/:id/accept" , to: "profile#accept" , as: "accept"
  post "/profile/:id/decline" , to: "profile#decline" , as: "decline"
  post "/profile/:id/cancel" , to: "profile#cancel" , as: "cancel"
  get '/message' , to: "profile#message" ,as: "message"

  resources :conversations do
    resources :messages
  end
end