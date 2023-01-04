Rails.application.routes.draw do
  root "dashboard#index"
  devise_for :users

  get 'dashboard/index'

  namespace :admins do
    resources :users, only: [:index, :new, :create, :edit, :update, :destroy]
  end
end
