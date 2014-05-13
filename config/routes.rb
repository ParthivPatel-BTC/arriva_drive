ArrivaDrive::Application.routes.draw do
  root :to => 'static_pages#index'
  devise_for :admins
  devise_for :participants, :controllers => { :registrations => "participants" } do
    resources :participants, only: [:show]
  end

  get '/new_participant' => 'static_pages#new_participant'
  get '/show' => 'static_pages#show'

  scope '/admins' do
    get 'dashboard', to: 'admins#dashboard', as: :admin_dashboard
  end
end
