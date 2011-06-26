Doweet::Application.routes.draw do
  get "calendar/index"
  resources :statuses
  get "home/index"
  get "friendships/index"
  get "calendar/monthcalendar"
  get "imported_contacts/index"
  root :to => "home#index"
  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
  match "home/newsfeed" => "home#newsfeed", :as => :newsfeed
  match "friendships/add" => "friendships#add", :as => :add
  match "friendships/requests" => "friendships#requests", :as => :requests
  match "friendships/confirm" => "friendships#confirm", :as => :confirm
  match "friendships/decline" => "friendships#decline", :as => :decline
  match "/like" => "statuses#like", :as => :like
  match "/comment" => "statuses#comment", :as => :comment
  
  
  
  match "home/doweet_button" => "statuses#doweet_button", :as => :doweet
  match "imported_contacts/authenticate" => "imported_contacts#authenticate"
  match "imported_contacts/authorise" => "imported_contacts#authorise"
  
  match "home/create" => "home#create", :as => :users
  match "home/login" => "sessions#create_regular_user", :as => :sessions
end
