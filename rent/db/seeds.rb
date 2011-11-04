# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
Role.delete_all
Status.delete_all
Did.delete_all
Company.delete_all
Building.delete_all
Listing.delete_all
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
statuses = Status.create!([
  {name: 'Currently Renting', ns: 'listing_status'}, {name: 'Rented', ns: 'listing_status'},
  {name: 'Application Pending', ns: 'listing_status'}, {name: 'Some CID Status', ns: 'cid_status'}  
])
dids = Did.create!([
  {number: '(347) 868-6692'}, {number: '(646) 553-6331'}, {number: '(646) 699-4692'}
])
companies = Company.create!([
  {name: 'Rose Associates'}
])
buildings = Building.create!([
  {address: '260 W. 52nd Street', company: companies.first},
  {address: '322 W. 57th St', company: companies.first},
  {address: '358 West 47th Street'}
])
listings = Listing.create!([
  {
    gist: 'One bedroom in a doorman building near Times Square', 
    pitch: 'This awesome apartment is in a full service doorman building and has plenty of light',
    unit: '6J',
    monthly_rent: '3015',
    rooms_total: 3,
    rooms_bed: 1,
    rooms_bath: 1,
    building: buildings.first,
    status: statuses.first
  },
  {
    gist: 'Sunlit two bedroom in a doorman building near Times Square', 
    pitch: 'This awesome apartment is in a full service doorman building and is awesome!!!',
    unit: '15-G',
    monthly_rent: '4050',
    rooms_total: 4,
    rooms_bed: 2,
    rooms_bath: 1,
    building: buildings.first,
    status: statuses.first
  }
])