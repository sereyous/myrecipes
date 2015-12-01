Rails.application.routes.draw do
  
  # homepage 
  root 'pages#home'
  get '/home', to: 'pages#home'
  
  resources :recipes do 
    member do 
      post 'like'
    end
  end
  
  resources :chefs, except: [:new]
  
  get '/register', to: 'chefs#new'
  
  get '/login' , to: "logins#new"
  get '/logout', to: "logins#destroy"
  post '/login', to: "logins#create"
  
end
