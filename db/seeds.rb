# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Admin Data

Rails.logger = Logger.new(STDOUT)

admin = Admin.create(email: 'admin@drive.com')
admin.password = "password"
admin.password_confirmation = "password"
admin.save
if admin.errors.empty?
	Rails.logger.info("Admin with #{admin.email} created.")
else
	Rails.logger.error(admin.errors.full_messages)
end
