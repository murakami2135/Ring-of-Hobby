# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :groups, only: %i(index new show create edit update destroy) do
    member do
      get :join
    end
  end
  get 'group/search' => 'groups#search'
  get 'group/participant' => 'groups#participant'
  resources :chats, only: %i(show create)
  resources :users, only: %i(show edit update) do
    resources :notifications, only: [:index]
  end
end
