module ApplicationHelper
  NUMBER_STR_MAP = {1 => 'One', 2 => 'Two', 3 => 'Three', 4 => 'Four'}
  def number_to_string(number)
    NUMBER_STR_MAP[number]
  end

  def image_present?(obj, image_attr_name)
    return false if obj.blank?
    !obj.try(image_attr_name).blank?
  end

  def image_link_valid?(obj)
    !obj.new_record?
  end
end
