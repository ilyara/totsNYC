# Application Generator Template
# Usage: rails new APP_NAME -m template.rb -T -O
# or - to apply template to existing project: rake rails:template LOCATION=~/template.rb

generate(:controller, 'home index')
generate(:controller, 'sessions new')
generate(:controller, 'oauth')
route "root :to => 'home#index'"
# match "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

#generate('sorcery:install', 'external remember_me')
#generate('scaffold', 'Pitch number:string')