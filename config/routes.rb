ArrivaDrive::Application.routes.draw do
  root :to => 'static_pages#index'
  devise_for :admins
  devise_for :participants

  scope '/admins' do
    get 'dashboard', to: 'admins#dashboard', as: :admin_dashboard
  end
end
