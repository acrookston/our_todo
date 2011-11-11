################################################################################
# Environment specific configuration
################################################################################

configure :development do
  ENV['MONGOID_DATABASE'] = 'mytodo'
end

configure :test do
  ENV['MONGOID_DATABASE'] = 'mytodo_test'
end

configure :production do
  ENV['MONGOID_DATABASE'] = 'mytodo'
end

################################################################################
# DB and Models
################################################################################

require './lib/mongoid'
require './lib/todo'
