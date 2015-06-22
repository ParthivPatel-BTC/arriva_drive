ArrivaDrive::Application.routes.draw do
  # root :to => 'static_pages#index'
  devise_for :admins do
    root :to => 'static_pages#index'
  end
  devise_for :participants, :controllers => { :registrations => "participants" }, :skip => [:sessions]

  devise_for :participants do
    get '/participant/:id/edit' => 'participants#edit', :as => :edit_participant
    get '/participant/:id' => 'participants#show', :as => :show_participant
    get '/participants/new' => 'participants#new_participant', :as => :new_participant
    post '/participants' => 'participants#create'
    post '/participants' => 'participants#update', :as => :update_participant
    put '/participants/:id/deactivate' => 'participants#deactivate', :as => :participant_deactivate
    put '/participants/:id/activate' => 'participants#activate', :as => :participant_activate
    post '/participants/resend_invitation' => 'participants#resend_invitation'
    get '/participant/:id/attachments' => 'participants#attachments', :as => :attachments
    post '/participant/:id' => 'participants#complete_online_course', :as => :complete_online_course_participant
  end

  get '/new_participant' => 'static_pages#new_participant'
  get '/show' => 'static_pages#show'

  scope '/admins' do
    resources :activities, except: [:index, :destroy]
    resources :events, except: [:index, :destroy]
    resources :cohorts, except: [:destroy]
    get 'dashboard', to: 'admins#dashboard', as: :admin_dashboard
    get 'overview/:id', to: 'admins#overview', as: :overview
    get 'overall_cohort_scores', to: 'admins#overall_cohort_scores', as: :overall_cohort_scores
    get 'event_attachments/:id' => 'events#download_event_file', :as => :event_file_download
  
    post 'events/:id/event_notification', to: 'events#send_email_notification', as: :send_event_notification
  end

  post '/:id/shared_participants' => 'participant/participant_attachments#shared_participants', as: 'get_shared_participant'
  scope '/participants' do
    get '/dashboard' => 'participant/home#dashboard', as: 'participant_dashboard'
    get '/:id/edit_profile' => 'participant/home#edit_profile', :as => :edit_profile
    post '/:id/update_profile' => 'participant/home#update_profile', :as => :update_profile
    resources :activities, controller: 'participant/activities', as: 'participant_activities'
    resources :behaviours, only: [:index], controller: 'participant/behaviours', as: 'participant_behaviours'
    resources :networks, only: [:index], controller: 'participant/networks', as: 'participant_networks'
    resources :participant_attachments, controller: 'participant/participant_attachments'
    get '/:id/shred_participants_list' => 'participant/participant_attachments#shared_participants_list', :as => :participants_list_participant_shared
    post '/:id/create_shared_participants' => 'participant/participant_attachments#create_shared_participants', as: 'create_shared_participants'

    resources :activities, only: [:index, :show], controller: 'participant/activities', as: 'participant_activities' do
      member do
        post 'answer_question'
        get  'new_review'
        post 'create_review'
      end
    end

    resources :notes, except: [:show, :edit, :update], controller: 'participant/notes', as: 'participant_notes' do
      collection do
        post 'tag_participants_list'
        post 'tag_behaviours_list'
        post 'tag_participants_behaviours'
        get 'get_note_content'
      end
    end

    resources :shared_attachments, except: [:show, :edit, :update], controller: 'participant/participant_attachments', as: 'participant_attachments' do
      collection do
        get 'shared_participants_list'
        post 'tag_participants_files'
      end
    end

    resources :events, only: [:index], controller: 'participant/events', as: 'participant_events' do
      member do
        get '/calendar_feed', to: 'participant/events#publish', as: :calendar_feed
      end
    end

    get '/all_participants' => 'participant/networks#get_all_participants'
    get '/seach_by_alpha_character' => 'participant/networks#seach_by_alpha_character'
    get '/add_to_network' => 'participant/networks#add_to_network'
    get '/get_monthly_events' => 'participant/events#get_monthly_events'
    get '/remove_participant' => 'participant/networks#remove_participant'
    get '/export_notes/:id' => 'participant/notes#export_notes', as: :export_notes
    post '/participant_attachments/callback' => 'participant/participant_attachments#callback'
    get '/participant_attachments/show_attachment/:id' => 'participant/participant_attachments#show_attachment', as: :show_attachment
  end
  get 'admin' => 'static_pages#admin'

  resources :incoming_mails
end
