Rails.application.routes.draw do
  root 'users#index'

  get '/login' => 'sessions#new'
  post '/sessions' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new', as: 'new_user'
  post '/users' => 'users#create', as: 'create_user'
  get 'users/:id' => 'users#profile', as: 'user'

  get '/search' => 'users#search_items'
  post '/save' => 'users#save_item'
  delete '/item/:id' => 'users#delete_item', as: 'delete_item'
  get '/find' => 'users#find_user'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
