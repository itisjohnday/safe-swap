Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :devices do
    resources :posts
  end

  get "/pages/:page" => "pages#show"

  root to: 'pages#about'
end
