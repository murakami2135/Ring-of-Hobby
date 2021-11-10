Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :groups, only: [:index, :new, :show, :create, :edit, :update, :destroy] do
    member do
      get :join
    end
  end
  get 'group/search' => 'groups#search'
  get "group/participant" => "groups#participant"
  resources :chats, only: [:show, :create]
  resources :users, only: [:show, :edit, :update]

end
