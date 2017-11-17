Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :sale_items

  get "/" => redirect("sale_items#index")
end
