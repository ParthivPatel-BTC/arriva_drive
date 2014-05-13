module ApplicationHelper
  NUMBER_STR_MAP = {1 => 'One', 2 => 'Two', 3 => 'Three', 4 => 'Four'}
  def number_to_string(number)
    NUMBER_STR_MAP[number]
  end
end
