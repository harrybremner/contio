Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :projects, except: [:new, :edit] do
    resources :messages, only: [:index]
    resources :tasks, only: [:create, :update, :show] do
      resources :sub_tasks, only: [:create, :update]
    end
  end
  resources :messages, only: [:create, :destroy]
  resources :tasks, only: [:destroy]
  resources :sub_tasks, only: [:destroy]
  resource :users, only: [:show]
  get "/messages", to: "projects#messages_index"
end


#above we have that we can see all projects on an index page, we can then select one project (show page)
# and then see the index of all tasks
# we can then click on the show page of a task which shows us an index of subtasks (on show page of the task)
# we can then see the show page of a subtask
