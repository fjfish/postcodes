Rails.application.routes.draw do
  get 'postcode_query/index'
  resources :lsoa_matchers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
