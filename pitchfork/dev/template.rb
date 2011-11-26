# Application Generator Template
# Usage: rails new APP_NAME -m template.rb -T -O
# or - to apply template to existing project: rake rails:template LOCATION=~/template.rb

# Created by Ilya@trinix.com
# v. 11/26/2011 15:27

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

generate('scaffold', 'Subscriber name:string created_by:references')
generate('scaffold', 'Venue name:string address:string created_by:references')
generate('scaffold', 'Event name:string subscriber:references venue:references rating_scale:references created_by:references')
generate('scaffold', 'Pitch name:string event:references user:references')
generate('scaffold', 'Deadline name:string event:references type:references created_by:references')
generate('scaffold', 'Note content:string type:references created_by:references')
generate('scaffold', 'Viewing pitch:references time_start:time time_end:time user:references')
generate('scaffold', 'Role name:string created_by:references')
generate('scaffold', 'RoleMap name:string user:references role:references event:references created_by:references')
generate('scaffold', 'Rating pitch:references note:string user:references')
generate('scaffold', 'RatingScale name:string description:string created_by:references')
generate('scaffold', 'RatingScaleStep rating_scale:references name:string score:integer created_by:references')
generate('scaffold', 'Vote pitch:references note:string user:references')
generate('scaffold', 'Status name:string')
generate('scaffold', 'Presentation name:string')
generate('scaffold', 'Journal action:references object:references description:string created_by:references')
generate('scaffold', 'Type name:string namespace:string')

generate('scaffold', 'User name:string role:references')

rake('db:migrate')

append_file 'db/seeds.rb' do <<-FILE
puts 'Seeding...'
ActiveRecord::Base.transaction do
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
  users = User.create([{name: 'Ilya', role:roles.last}, {name: 'Noah', role:roles.last}, {name: 'Evan', role:roles.first}])

  subscribers = Subscriber.create([{name:'Startup Weekend', created_by:users.first}])
  venues = Venue.create([{name:'General Assembly', created_by:users.first}])
  events = Event.create([{name:'Startup Weekend - November 2011 - at General Assembly', subscriber:subscribers.first, venue:venues.first, rating_scale:rating_scales.first, created_by:users.first}])
  Deadline.create([{name:'test deadline', event:events.first, created_by:users.first}])
  Pitch.create([{name:'Test pitch', event:events.first, user:users.second}])
end
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
