# frozen_string_literal: true

Rails.application.routes.draw do
  
  devise_for :users
  
  resources :likes
  resources :follow_requests
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "users#feed"

  get "/search" => "spotify#search_form", as: :search
  get "/search_results" => "spotify#return_search_results", as: :search_results
  get "/song/:path_id" => "spotify#song_details", as: :song_details

  get "user_index" => "users#user_index", as: :user_index
  get ":username" => "users#show", as: :user
  get ":username/feed" => "users#feed", as: :feed






end
