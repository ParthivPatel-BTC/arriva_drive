ArrivaDrive::Application.routes.draw do
  # root :to => 'static_pages#index'
  devise_for :admins do
    root :to => 'devise/sessions#new'
  end
  devise_for :participants, :controllers => { :registrations => "participants" }, :skip => [:sessions]

  devise_for :participants do
    get '/participant/:id/edit' => 'participants#edit', :as => :edit_participant
    get '/participant/:id' => 'participants#show', :as => :show_participant
    get '/participants/new' => 'participants#new', :as => :new_participant
    post '/participants' => 'participants#create'
    post '/participants' => 'participants#update', :as => :update_participant
    put '/participants/:id/deactivate' => 'participants#deactivate', :as => :participant_deactivate
    put '/participants/:id/activate' => 'participants#activate', :as => :participant_activate
    post '/participants/resend_invitation' => 'participants#resend_invitation'
  end
  get '/new_participant' => 'static_pages#new_participant'
  get '/show' => 'static_pages#show'

  scope '/admins' do
    resources :activities, except: [:index, :destroy]
    resources :events, except: [:index, :destroy]

    get 'dashboard', to: 'admins#dashboard', as: :admin_dashboard
    get 'overview/:id', to: 'admins#overview', as: :overview
  end
end
