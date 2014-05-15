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

  def after_sign_in_path_for(resource)
    admin_dashboard_path
  end

  private

  def set_behaviours
    @behaviours = Behaviour.all
  end

  # Loop through all nested attributes and marks attributes which
  # will be destroyed when the parent is saved
  def mark_nested_attr_for_destroy(params, nested_attr_name, marked_attr_name)
    return params if params[nested_attr_name].blank?
    params[nested_attr_name].each do |nested_attr_map|
      attrs_filled = nested_attr_map.keys
      # If the nested attribute have 'id' and it does not have 'marked_attribute'
      # then mark this nested attribute so it will be destroyed
      if attrs_filled.include?('id') && attrs_filled.exclude?(marked_attr_name)
        # to delete the nested element when parent is saved
        # we just have to set '_destroy' as true
        nested_attr_map['_destroy'] = true
      end
    end
    params
  end

  def require_admin
    msg = (current_user.is_admin? ? '' : t('permissions.not_permitted'))
    access_denied_redirect(msg)
  end

  def is_admin?
    current_user.email == Admin.first.email
  end

  def required_access
    unless current_user.has_permission?(params[:controller].to_sym)
      access_denied_redirect(t('permissions.not_permitted'))
    end
  end
end
