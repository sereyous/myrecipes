# == Route Map
#
#            Prefix Verb   URI Pattern                               Controller#Action
#              root GET    /                                         pages#home
#              home GET    /home(.:format)                           pages#home
#    recipe_reviews GET    /recipes/:recipe_id/reviews(.:format)     reviews#index
#                   POST   /recipes/:recipe_id/reviews(.:format)     reviews#create
# new_recipe_review GET    /recipes/:recipe_id/reviews/new(.:format) reviews#new
#       edit_review GET    /reviews/:id/edit(.:format)               reviews#edit
#            review GET    /reviews/:id(.:format)                    reviews#show
#                   PATCH  /reviews/:id(.:format)                    reviews#update
#                   PUT    /reviews/:id(.:format)                    reviews#update
#                   DELETE /reviews/:id(.:format)                    reviews#destroy
#       like_recipe POST   /recipes/:id/like(.:format)               recipes#like
#           recipes GET    /recipes(.:format)                        recipes#index
#                   POST   /recipes(.:format)                        recipes#create
#        new_recipe GET    /recipes/new(.:format)                    recipes#new
#       edit_recipe GET    /recipes/:id/edit(.:format)               recipes#edit
#            recipe GET    /recipes/:id(.:format)                    recipes#show
#                   PATCH  /recipes/:id(.:format)                    recipes#update
#                   PUT    /recipes/:id(.:format)                    recipes#update
#                   DELETE /recipes/:id(.:format)                    recipes#destroy
#             chefs GET    /chefs(.:format)                          chefs#index
#                   POST   /chefs(.:format)                          chefs#create
#         edit_chef GET    /chefs/:id/edit(.:format)                 chefs#edit
#              chef GET    /chefs/:id(.:format)                      chefs#show
#                   PATCH  /chefs/:id(.:format)                      chefs#update
#                   PUT    /chefs/:id(.:format)                      chefs#update
#          register GET    /register(.:format)                       chefs#new
#             login GET    /login(.:format)                          logins#new
#            logout GET    /logout(.:format)                         logins#destroy
#                   POST   /login(.:format)                          logins#create
#            styles POST   /styles(.:format)                         styles#create
#         new_style GET    /styles/new(.:format)                     styles#new
#             style GET    /styles/:id(.:format)                     styles#show
#       ingredients POST   /ingredients(.:format)                    ingredients#create
#    new_ingredient GET    /ingredients/new(.:format)                ingredients#new
#        ingredient GET    /ingredients/:id(.:format)                ingredients#show
#

Rails.application.routes.draw do
  
  # homepage 
  root 'pages#home'
  get '/home', to: 'pages#home'
  
  resources :recipes do 
    resources :reviews, shallow: true
    member do 
      post 'like'
    end
  end
  
  resources :chefs, except: [:new, :destroy] do
    member do 
      get 'reviews'
    end
  end
  
  get '/register', to: 'chefs#new'
  
  get '/login' , to: "logins#new"
  get '/logout', to: "logins#destroy"
  post '/login', to: "logins#create"
  
  resources :styles, only: [:new, :create, :show]
  resources :ingredients, only: [:new, :create, :show]
  
end
