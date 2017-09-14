Rails.application.routes.draw do
  get 'listings/create' => 'listings#create'
  root 'listings#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
