Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :projects do
    resources :messages, only: [:show]
    resources :tasks, except: [:index, :destroy] do
      resources :sub_tasks, only: [:show, :create, :update]
    end
  end
  resources :messages, only: [:create, :destroy]
  resources :tasks, only: [:destroy]
  resources :sub_tasks, only: [:destroy]
end
