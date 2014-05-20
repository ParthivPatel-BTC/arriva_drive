module ApplicationHelper
  NUMBER_STR_MAP = {1 => 'One', 2 => 'Two', 3 => 'Three', 4 => 'Four'}
  def number_to_string(number)
    NUMBER_STR_MAP[number]
  end

  # For flash messages
  def bootstrap_class_for flash_type
    case flash_type
    when :success
      "alert-success" # Green
    when :error
      "alert-danger" # Red
    when :alert
      "alert-warning" # Yellow
    when :notice
      "alert-info" # Blue
    else
      flash_type.to_s
    end
  end

  def image_present?(obj, image_attr_name)
    return false if obj.blank?
    !obj.try(image_attr_name).blank?
  end

  def image_link_valid?(obj)
    !obj.new_record?
  end

  def find_field_length(str)
    str.try(:size) || 0
  end

  def formatted_date(date)
    date.strftime('%d/%m/%Y') rescue nil
  end

  def determine_root_path
    return root_path if current_admin.blank?
    admin_dashboard_path
  end

  # For display admin full name in header after sign in
  def full_name(first_name, last_name)
    "#{first_name} #{last_name}"
  end

  def common_text_field_class
    'form-control'
  end
end
