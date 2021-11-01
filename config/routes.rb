Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :groups, only: [:index, :new, :show, :create, :edit, :update, :destroy]
  resources :users, only: [:show, :edit]
  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create]
end
