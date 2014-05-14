ArrivaDrive::Application.routes.draw do
  root :to => 'static_pages#index'
  devise_for :admins
  devise_for :participants, :controllers => { :registrations => "participants" }, :skip => [:sessions]

  devise_for :participants do
    get '/participant/:id/edit' => 'participants#edit', :as => :edit_participant
    get '/participant/:id' => 'participants#show', :as => :show_participant
  end

  get '/new_participant' => 'static_pages#new_participant'
  get '/show' => 'static_pages#show'

  scope '/admins' do
    get 'dashboard', to: 'admins#dashboard', as: :admin_dashboard
  end
end
