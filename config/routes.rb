Rails.application.routes.draw do
  resources :events
  get "events/:id/delete_confirm", to: "events#delete_confirm"
  
  resources :exercises
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
