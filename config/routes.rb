Rails.application.routes.draw do

  resources :users, controller: "users", only: [:create] do
	end
  # get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  # delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  # get "/sign_up" => "clearance/users#new", as: "sign_up"pp
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to:"home#home"

# the following get first '/about' is the url path, the second 'about_us' is matched with the controller, and the 'about' after the '#' refers to the method, which is defined in controller
# the about.html.erb file is supposed to follow the method and not the controller
get '/about' =>"about_us#about", as:"about"
end


