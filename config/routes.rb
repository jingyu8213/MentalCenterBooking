# frozen_string_literal: true

Rails.application.routes.draw do
  resources :rooms
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'users#index'
  get 'signup' => 'users#new'
end
