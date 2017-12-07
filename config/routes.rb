Rails.application.routes.draw do
  root 'users#index'

  get '/login' => 'sessions#new'
  post '/sessions' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new', as: 'new_user'
  post '/users' => 'users#create'
  get 'users/:id' => 'users#profile', as: 'user'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
