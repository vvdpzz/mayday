Mayday::Application.routes.draw do

  devise_for :users

  match "questions/tagged/:tag" => "questions#tagged", :via => "get", :as => :tagged
  resources :questions do
    resources :answers
  end

  root :to => "questions#index"
end
