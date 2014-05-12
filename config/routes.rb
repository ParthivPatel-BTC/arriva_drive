ArrivaDrive::Application.routes.draw do
  devise_for :admins
  devise_for :participants
end
