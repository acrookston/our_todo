require 'sinatra/base'
require 'mongoid'

module Sinatra
  module MongoidExtension
    def self.registered(app)
      if ENV['MONGOHQ_URL']
        uri = URI.parse(ENV['MONGOHQ_URL'])
        conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
        Mongoid.database = conn.db(uri.path.gsub(/^\//, ''))
        # Mongoid.add_language("sv")
      else
        app.set :mongo_host,     ENV['MONGOID_HOST']      || 'localhost'
        app.set :mongo_db,       ENV['MONGOID_DATABASE']  || 'changeme'
        app.set :mongo_port,     ENV['MONGOID_PORT']      || Mongo::Connection::DEFAULT_PORT
        app.set :mongo_user,     ENV['MONGOID_USERNAME']
        app.set :mongo_password, ENV['MONGOID_PASSWORD']
        
        begin
          Mongoid.database = Mongo::Connection.new(app.mongo_host,app.mongo_port).db(app.mongo_db)
          if app.mongo_user
            Mongoid.database.authenticate(app.mongo_user, app.mongo_password)
          end
          # Mongoid.add_language("sv")
        rescue
          puts "Start your mongod server!"
          raise "MongoDB server went away"
        end
      end
    end
  end
  register MongoidExtension
end