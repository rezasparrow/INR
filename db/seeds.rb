# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
  admin = User.create({email: 'admin@admin.com', password_confirmation: 'Admin2016', password: 'Admin2016', role: 'ادمین' , company_name: '' , work_experience: '0' , register_number: '' , tel: '09125038261' , fax: '' , father_id: '0', name: 'maede' , inclinic: ''})
  





