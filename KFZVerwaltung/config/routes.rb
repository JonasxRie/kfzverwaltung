Rails.application.routes.draw do

  post 'fahrzeugs/archive' => 'fahrzeugs#archive'
  post 'dokuments/download_file' => 'dokuments#download_file'

  resources :dokuments
  resources :fahrzeugs

  root 'fahrzeugs#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
