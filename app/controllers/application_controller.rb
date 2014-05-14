class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Add Custom Field/Column to Devise with Rails 4
  # Reference : http://stackoverflow.com/questions/16297797/add-custom-field-column-to-devise-with-rails-4
  before_action :configure_devise_permitted_parameters, if: :devise_controller?

  protected

  def configure_devise_permitted_parameters
    registration_params = [:first_name, :last_name, :job_title, :division, :year_started, :photo, :performance_summary, :email, :password, :password_confirmation, scores_attributes: [:id, :behaviour_id, :score] ]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) {
        |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) {
        |u| u.permit(registration_params)
      }
    end
  end
end
