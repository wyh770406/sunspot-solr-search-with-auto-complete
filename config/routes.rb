JxbSearch::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users, :only => [:show, :index]

  match "/search" => "search#index", :as => :search
  match "/autocomplete_keyword_word" => "home#autocomplete_keyword_word", :as => :autocomplete_keyword_word  
end
