# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Admin Data

Rails.logger = Logger.new(STDOUT)

def find_or_create_instance(class_name, attr_map, find_by_attr)
  instance  = class_name.where(find_by_attr => attr_map[find_by_attr])
  if instance.blank?
    instance = class_name.create(attr_map)
    name = instance.try(:name) ? instance.name : class_name
    Rails.logger.info "#{name} created successfully"
  else
    Rails.logger.info "#{class_name} already exist, so did not created"
  end
  instance
end

# =========================== Create Admin
admin_attr = {
  email:      'admin@drive.com',
  password:   'password',
}
find_or_create_instance(Admin, admin_attr, :email)
