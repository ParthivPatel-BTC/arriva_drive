ArrivaDrive::Application.routes.draw do
  devise_for :admins
  devise_for :participants

  scope '/admin' do
    get 'dashboard', to: 'admins#dashboard', as: :admin_dashboard
  end
end
