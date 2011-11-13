################################################################################
# Environment specific configuration
################################################################################

configure :development do
  ENV['MONGOID_DATABASE'] = 'ourtodo'
end

configure :test do
  ENV['MONGOID_DATABASE'] = 'ourtodo_test'
end

configure :production do
  ENV['MONGOID_DATABASE'] = 'ourtodo'
end

################################################################################
# DB and Models
################################################################################

require './lib/mongoid'
require './lib/todo'
