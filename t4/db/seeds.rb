# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'Seeding...'
# Role.delete_all
# Person.delete_all
# Location.delete_all
# roles = Role.create([{ name: 'Parent' }, { name: 'Child' }])
# Person.create(nick: 'Ilya', role: roles.first)
# Location.create([{name: 'Tots Playground', latitude: '40.77332', longitude: '-73.976974'},
# {name: 'Rudin Family Playground', latitude: '40.7916396', longitude: '-73.9647091'}
# ])
PhoneId.create([{number: '12124897820'}, {number: '16466427820'}])
