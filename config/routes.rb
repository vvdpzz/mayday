Mayday::Application.routes.draw do

  devise_for :users

  match "questions/tagged/:tag" => "questions#tagged", :via => "get", :as => :tagged
  resources :questions do
    resources :answers, :except => [:index, :show]
    resources :comments, :only => [:new, :create]
  end
  resources :answers, :except => [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :comments, :only => [:new, :create]
  end

  root :to => "questions#index"
end
