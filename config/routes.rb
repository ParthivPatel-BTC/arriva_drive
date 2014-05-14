ArrivaDrive::Application.routes.draw do
  root :to => 'static_pages#index'
  devise_for :admins
  devise_for :participants

  get '/new_participant' => 'static_pages#new_participant'
  get '/show' => 'static_pages#show'

  scope '/admins' do
    resources :activities, except: [:index, :destroy]
    resources :events, except: [:index, :destroy]

    get 'dashboard', to: 'admins#dashboard', as: :admin_dashboard
  end
end
