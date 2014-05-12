ArrivaDrive::Application.routes.draw do
  root :to => 'static_pages#index'
  devise_for :admins
  devise_for :participants

  get '/new_participant' => 'static_pages#new_participant'
end
