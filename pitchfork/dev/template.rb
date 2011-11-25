# Application Generator Template
# Usage: rails new APP_NAME -m template.rb -T -O
# or - to apply template to existing project: rake rails:template LOCATION=~/template.rb

generate('sorcery:install', 'external remember_me')
generate('scaffold', 'Pitch number:string')