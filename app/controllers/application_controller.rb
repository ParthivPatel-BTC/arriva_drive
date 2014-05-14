class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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
end
