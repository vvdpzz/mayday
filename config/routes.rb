Mayday::Application.routes.draw do
  
  devise_for :users
  resources :users
  
  match "users/notify" => "users#notify"
  match "users/done" => "users#done"
  match "users/show" => "users#show"

  match "questions/tagged/:tag" => "questions#tagged", :via => "get", :as => :tagged
  match "questions/:id/answers/:answer_id/accept" => "questions#accept", :via => "get", :as => :accept
  resources :questions do
    resources :answers, :except => [:index, :show]
    resources :comments, :only => [:new, :create]
    get :autocomplete_tag_name, :on => :collection
  end
  resources :answers, :except => [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :comments, :only => [:new, :create]
  end
  
  resources :editing_help, :only => [:index]

  root :to => "questions#index"
end
