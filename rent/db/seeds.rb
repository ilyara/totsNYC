# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
Role.delete_all
Did.delete_all
Company.delete_all
Building.delete_all
roles = Role.create!([
  {rolename: 'admin', description: 'Administrator'}, 
  {rolename: 'agent', description: 'Broker Agent'},
  {rolename: 'renter', description: 'Prospective Renter'}
])
users = User.create!([
  {username: 'ilya', email: 'ilya@trinix.com', password: '123', role: roles.first},
  {username: 'grezis', email: 'grezis@gmail.com', password: '123', role: roles.second},
  {username: 'lit', email: 'lit@piva.net', password: '123', role: roles.third}
])
dids = Did.create!([
  {number: '(347) 868-6692'}, {number: '(646) 553-6331'} 
])
companies = Company.create!([
  {name: 'Rose Associates'}
])
building = Building.create!([
  {address: '260 W. 52nd Street', company: companies.first},
  {address: '322 W. 57th St', company: companies.first},
  {address: '358 West 47th Street'}
])