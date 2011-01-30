Mayday::Application.routes.draw do

  devise_for :users

  resources :questions
  
  root :to => "questions#index"
end
