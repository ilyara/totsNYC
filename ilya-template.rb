# Application Generator Template
# Usage: rails new APP_NAME -m ilys-template.rb -T -O

gem 'haml-rails', :group => :development
gem 'nifty-generators', :group => :development
generate(:controller, 'home index')
route "root :to => 'home#index'"
generate('scaffold', 'User name:string role:references')
generate('scaffold', 'Person nick:string role:references')
generate('scaffold', 'Role name:string')
generate('scaffold', 'Tag name:string')
generate('scaffold', 'Tagging tag:references obj:string')
generate('scaffold', 'PlayDate name:string location:references')
generate('scaffold', 'Signup play_date:references person:references')
generate('scaffold', 'CallLog phone_id:references start_time:datetime duration:number comments:string')
generate('scaffold', 'PhoneId number:string')
generate('scaffold', 'Location name:string latitude:float longitude:float')
rake('db:migrate')
append_file 'db/seeds.rb' do <<-FILE
puts 'Seeding...'
Role.delete_all
Person.delete_all
Location.delete_all
roles = Role.create([{name: 'Parent'}, {name: 'Child'}, {name: 'Caretaker'}])
Person.create(nick: 'Ilya', role: roles.first)
Location.create([{name: 'Tots Playground', latitude: '40.77332', longitude: '-73.976974'},
{name: 'Rudin Family Playground', latitude: '40.7916396', longitude: '-73.9647091'}
])
PhoneId.create([{number: '12124897820'}, {number: '16466427820'}])
FILE
end
rake('db:seed')
append_file 'app/views/home/index.html.haml' do <<-FILE

.links
  = link_to "People", people_path 
  = link_to "Roles", roles_path
  = link_to "Locations", locations_path
  = link_to "CallLogs", call_logs_path
  = link_to "PhoneIds", phone_ids_path
  = link_to "PlayDates", play_dates_path
  = link_to "Signups", signups_path
  = link_to "Tags", tags_path
  = link_to "Taggings", taggings_path

FILE
end
remove_file 'public/index.html'
run 'mate .'