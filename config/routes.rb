require 'sidekiq/web'

Rails.application.routes.draw do

mount Sidekiq::Web => '/sidekiq'


  get '/braintree/new'

  resources :listings ,except: [:show, :index] do 
    resources :reservations , only: [:new, :create] 
  end
  resources :reservations , only: [:show, :edit, :update, :index]

  resources :users, controller: "users" do

  end
  # resources :listings, controller: "listings" do
  # end

  # get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  # delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  # get "/sign_up" => "clearance/users#new", as: "sign_up"pp
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to:"home#home"

# the following get first '/about' is the url path, the second 'about_us' is matched with the controller, and the 'about' after the '#' refers to the method, which is defined in controller
# the about.html.erb file is supposed to follow the method and not the controller
get '/about' =>"about_us#about", as:"about"
get "/auth/:provider/callback" => "sessions#create_from_omniauth"
get "listings" => "listings#listings"
get "/listings/:id"=>"listings#list"
get "/listings/:id/verify"=>"listings#verify"
post "/listings/:id/verify"=>"listings#verify"
get "/users/:id/edit"=>"users#edit"
get "/listings/:id/carousel" =>"listings#carousel", as:"carousel"
get "welcome/index" =>"welcome#index"
post "/braintree/checkout", as: "braintree_checkout"
post "/search" => "listings#search", as: "search"

# get "/listings/:id/reservations/new" =>"reservations#new", as:"newres"
# post "/listings/:id/reservations/new" =>"reservations#create"

end


