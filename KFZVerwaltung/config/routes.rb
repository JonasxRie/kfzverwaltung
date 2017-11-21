Rails.application.routes.draw do
  resources :dokuments
  resources :fahrzeugs

  root 'fahrzeugs#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
