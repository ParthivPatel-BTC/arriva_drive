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


#==================================================Create Behaviours===================================================
behaviours = [
    { title: 'Customer orientation', description: 'Entails knowing customer expectations and implementing customer-oriented solutions. For executives this also means acting in a manner that has a positive effect on the customer orientation of the employees.' },
    { title: 'Target & results focus', description: 'Is the endeavour to achieve outstanding results in one’s own area. This also includes setting oneself challenging targets, reviewing these and setting priorities to ensure company success.' },
    { title: 'Strategic focus', description: 'Requires the ability to recognise and understand structures and processes in organisations together with internal and external organisational influences, integrating these accordingly into one’s own activities for the benefit of the company.' },
    { title: 'Managing & developing people', description: 'Refers to the ability to create a trusting, appreciative and collaborative working environment and managing conflict constructively to achieve improved staff performance and employee satisfaction. This also includes the ability to identify and develop employee potential.' },
    { title: 'Striving for innovation', description: 'Entails the capability and will to improve the company’s performance, for example, by developing and testing new processes and products. This also means not being satisfied with the status quo but always looking out for improvements.' },
    { title: 'Change management', description: 'Consists of recognising change dynamics and striving for continuous improvement. This includes the ability to effectively convey the need for change and actively include stakeholders.' },
    { title: 'Cross-unit co-operation', description: 'Always striving for solutions-focused collaboration across all stakeholder groups both inside and outside the immediate team and company to constantly optimise business performance.' },
    { title: 'Corporate responsibility', description: 'Is the willingness to assume responsibility for topics going over and beyond one’s own area, to take decisions for the good of the company and to be aware of the short-term and long-term consequences for oneself and others. This means making high demands of the quality of both one’s own actions and the actions of others.' },
    { title: 'Role model function', description: 'Is the ability and willingness to align one’s own behaviour according to the needs, expectations and priorities of the company on an internal and external level so as to encourage others to do the same. This includes acting as a credible representative of the company.' },
    { title: 'Dealing with complexity', description: 'Refers to the ability to understand the complexity within and across the areas in which he/she works and to take decisions based on both analytical and people-centred approaches.' }
]

def find_or_create_behaviour(behaviour_attrs)
  title = behaviour_attrs[:title]
  behaviour = Behaviour.find_by_title(title)
  if behaviour.nil?
    behaviour = Behaviour.create(behaviour_attrs)
    puts "Created behaviour having title #{behaviour.title}"
  else
    behaviour.update_attributes(behaviour_attrs)
    puts "Updating behaviour having title #{behaviour.title}"
  end
  behaviour
end

behaviours.each { |behaviour| find_or_create_behaviour(behaviour)}