Mayday::Application.routes.draw do
  
  resources :brainstorms

  devise_for :users
  resources :users, :only => [:show]
  
  resources :recharge, :except => [:edit, :update, :destroy] do
    collection do
      post :notify
      get :done
    end
  end

  match "questions/tagged/:tag" => "questions#tagged", :via => "get", :as => :tagged
  match "questions/:id/answers/:answer_id/accept" => "questions#accept", :via => "get", :as => :accept
  resources :questions do
    resources :answers, :except => [:index, :show]
    resources :comments, :only => [:new, :create]
    collection do
      get :autocomplete_tag_name
      # post :update_attribute_on_the_spot
    end
  end
  resources :answers, :except => [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :comments, :only => [:new, :create]
  end
  
  resources :editing_help, :only => [:index]

  root :to => "questions#index"
end
