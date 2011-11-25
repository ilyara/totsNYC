# Application Generator Template
# Usage: rails new APP_NAME -m template.rb -T -O
# or - to apply template to existing project: rake rails:template LOCATION=~/template.rb

# generate(:controller, 'home index')
# generate(:controller, 'oauths')
# route "root :to => 'home#index'"
# route "'logout' => 'oauths#destroy', :as => :logout"
# 
# # match "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
# 
# #generate('sorcery:install', 'external remember_me')

gem 'haml-rails', :group => :development
gem 'nifty-generators', :group => :development

generate('nifty:layout --haml')

generate(:controller, 'home index')
route "root :to => 'home#index'"

generate('scaffold', 'Subscriber name:string')
generate('scaffold', 'Venue name:string address:string')
generate('scaffold', 'Event name:string subscriber:references venue:references rating_scale:references')
generate('scaffold', 'Pitch name:string user:references event:references')
generate('scaffold', 'Deadline name:string event:references type:references')
generate('scaffold', 'Note content:string type:references')
generate('scaffold', 'Viewing user:references pitch:references time_start:time time_end:time')
generate('scaffold', 'Role name:string')
generate('scaffold', 'RoleMap name:string user:references role:references event:references')
generate('scaffold', 'Rating user:references pitch:references note:string')
generate('scaffold', 'RatingScale name:string description:string')
generate('scaffold', 'RatingScaleStep rating_scale:references name:string score:integer')
generate('scaffold', 'Vote user:references pitch:references note:string')
generate('scaffold', 'Status name:string')
generate('scaffold', 'Presentation name:string')

generate('scaffold', 'User name:string role:references')

rake('db:migrate')

append_file 'db/seeds.rb' do <<-FILE
puts 'Seeding...'
RatingScale.delete_all
RatingScaleStep.delete_all
Role.delete_all
Subscriber.delete_all
Venue.delete_all
Event.delete_all
Deadline.delete_all
Pitch.delete_all

rating_scales = RatingScale.create([{name:'Default'}])

RatingScaleStep.create([
{rating_scale:rating_scales.first, name:'Like', score:3}, 
{rating_scale:rating_scales.first, name:'Maybe', score:2}, 
{rating_scale:rating_scales.first, name:'Not so much', score:1}])

roles = Role.create([{name:'Public'}, {name:'Voter'}, {name:'Submitter'}, {name:'Admin'}])
User.create(name: 'Ilya', role: roles.first)

subscribers = Subscriber.create([{name: 'Startup Weekend'}])
venues = Venue.create([{name: 'General Assembly'}])
events = Event.create([{name: 'Startup Weekend - November 2011 - at General Assembly', subscriber:subscribers.first, venue:venues.first, rating_scale:rating_scales.first}])
Deadline.create([{name:'test deadline', event:events.first}])
Pitch.create([{name:'Test pitch', event:events.first}])
FILE
end

rake('db:seed')

remove_file 'public/index.html'

# append_file 'app/views/home/index.html.haml' do <<-FILE
# 
# .links
#   = link_to "Subscribers", people_path 
#   = link_to "Venues", roles_path
#   = link_to "Events", locations_path
#   = link_to "Pitches", call_logs_path
#   = link_to "Deadlines", phone_ids_path
#   = link_to "Notes", play_dates_path
#   = link_to "Viewings", signups_path
#   = link_to "Roles", tags_path
#   = link_to "RoleMaps", taggings_path
# 
# FILE
