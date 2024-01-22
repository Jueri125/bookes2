Rails.application.routes.draw do

  root to: 'homes#top'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :books, only: [:new, :create, :index, :show, :destroy, :update, :edit, :show_b ]

  resources :books do
  member do
    get 'show'
    get 'show_b'
   end
end

  get "/home/about" => "homes#about", as: "about"
  resources :users, only: [ :index, :show, :update, :edit]
  patch 'books/:id' => 'books#update', as: 'update_book'
  patch 'users/:id' => 'users#update', as: 'update_user'


end
